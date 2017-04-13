AddCSLuaFile()

game.AddAmmoType({name = "glgrenades"})
if CLIENT then
	language.Add("glgrenades_ammo", "Pipebombs")
end

SWEP.PrintName = "Grenade Launcher"
SWEP.Instructions = [[<color=green>[PRIMARY FIRE]</color> Launch a grenade.

Grenades will explode shortly after impact with surfaces.

Grenades deal more damage on direct hits.]]

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true

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

local ShootSound = Sound("weapons/grenade_launcher1.wav")

function SWEP:CanPrimaryAttack()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) > 0
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:ShootEffects()
	self:EmitSound(ShootSound)

	if CLIENT then return end

	local nade = ents.Create("ent_launchedgrenade")

	if not IsValid(nade) then return end

	nade:SetOwner(self.Owner)
	nade:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector() * 16))
	nade:SetAngles(self.Owner:EyeAngles())
	nade:Spawn()

	local phys = nade:GetPhysicsObject()
	if not IsValid(phys) then nade:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1200
	phys:ApplyForceCenter(velocity)

	if self.Owner:GetAmmoCount(self.Primary.Ammo) > self.Primary.DefaultClip then
		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end

	self.Owner:RemoveAmmo(1, self.Primary.Ammo)
end

function SWEP:CanSecondaryAttack()
	return false
end

-- reload handling

SWEP.reloadtimer = 0

function SWEP:SetupDataTables()
	self:DTVar("Bool", 0, "reloading")
end

function SWEP:Reload()
	if self.dt.reloading then return end

	if not IsFirstTimePredicted() then return end

	if self.Owner:GetAmmoCount(self.Primary.Ammo) < self.Primary.DefaultClip and self:StartReload() then
		return
	end
end

function SWEP:StartReload()
	if self.dt.reloading then
		return false
	end

	if not IsFirstTimePredicted() then return false end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local wep = self

	if self.Owner:GetAmmoCount(self.Primary.Ammo) >= self.Primary.DefaultClip then
		return false
	end

	self:SetBodygroup(0, 1)
	wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

	self.reloadtimer = CurTime() + wep:SequenceDuration()

	self.dt.reloading = true

	return true
end

function SWEP:PerformReload()
	-- prevent normal shooting in between reloads
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if SERVER then
		self.Owner:GiveAmmo(1, self.Primary.Ammo, true)
	end

	self:SendWeaponAnim(ACT_VM_RELOAD)
	self:EmitSound(Sound("weapons/shotgun/shotgun_reload" .. math.random(1, 3) .. ".wav"))

	self.reloadtimer = CurTime() + self:SequenceDuration() + 0.2
end

function SWEP:FinishReload()
	self.dt.reloading = false
	self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	self:SetBodygroup(0, 0)
	self.reloadtimer = CurTime() + self:SequenceDuration()
end


function SWEP:Think()
	local ammo = self.Owner:GetAmmoCount(self.Primary.Ammo)
	
	if ammo <= 0 then
		self:Reload()
	end

	if self.dt.reloading and IsFirstTimePredicted() then
		if self.Owner:KeyDown(IN_ATTACK) and ammo > 0 then
			self:FinishReload()
			return
		end

		if self.reloadtimer <= CurTime() then
			if ammo >= self.Primary.DefaultClip then
				self:FinishReload()
			elseif ammo < self.Primary.DefaultClip then
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
