AddCSLuaFile()

game.AddAmmoType({name = "glgrenades"})
if CLIENT then
	language.Add("glgrenades_ammo", "Pipebombs")
end

SWEP.PrintName = "Grenade Launcher"

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "glgrenades"

SWEP.Primary.Delay = 0.8

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

local ShootSound = Sound("de")

function SWEP:CanPrimaryAttack()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) > 0
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + SWEP.Primary.Delay)

	self:EmitSound(ShootSound)

	if CLIENT then return end

	local nade = ents.Create("ent_launchedgrenade")

	if not IsValid(nade) then return end

	ent:SetOwner(self.Owner)
	ent:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector() * 16))
	ent:SetAngles(self.Owner:EyeAngles())
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if not IsValid(phys) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 100
	phys:ApplyForceCenter(velocity)

	if self.Owner:GetAmmoCount(self.Primary.Ammo) > self.Primary.DefaultClip then
		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end

	self.Owner:RemoveAmmo(1, self.Primary.Ammo)

	if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
		self.needs_reload = true
	end
end

function SWEP:CanSecondaryAttack()
	return false
end

-- reload handling

SWEP.reloadtimer           = 0

function SWEP:SetupDataTables()
   self:DTVar("Bool", 0, "reloading")

   return self.BaseClass.SetupDataTables(self)
end

function SWEP:Reload()
	if self.dt.reloading then return end

	if not IsFirstTimePredicted() then return end

	if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then

		if self:StartReload() then
			return
		end
	end
end

function SWEP:StartReload()
	if self.dt.reloading then
		return false
	end

	if not IsFirstTimePredicted() then return false end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local wep = self

	if wep:Clip1() >= self.Primary.ClipSize then
		return false
	end

	wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

	self.reloadtimer =  CurTime() + wep:SequenceDuration()

	self.dt.reloading = true

	return true
end

function SWEP:PerformReload()
	local ply = self.Owner

	-- prevent normal shooting in between reloads
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self.Owner:GiveAmmo(1, self.Primary.Ammo, true)

	self:SendWeaponAnim(ACT_VM_RELOAD)

	self.reloadtimer = CurTime() + self:SequenceDuration()
end

function SWEP:FinishReload()
	self.dt.reloading = false
	self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

	self.reloadtimer = CurTime() + self:SequenceDuration()
end


function SWEP:Think()
	if self.needs_reload then
		self:Reload()
	end

	if self.dt.reloading and IsFirstTimePredicted() then
		if self.Owner:KeyDown(IN_ATTACK) then
			self:FinishReload()
			return
		end

		if self.reloadtimer <= CurTime() then
			if self.Owner:GetAmmoCount(self.Primary.Ammo) >= self.Primary.DefaultClip then
				self:FinishReload()
			elseif self.Owner:GetAmmoCount(self.Primary.Ammo) < self.Primary.DefaultClip then
				self:PerformReload()
			else
				self:FinishReload()
			end
			return
		end
	end
end

function SWEP:Deploy()
	self.dt.reloading = false
	self.reloadtimer = 0
	return self.BaseClass.Deploy(self)
end
