AddCSLuaFile()

game.AddAmmoType({name = "m16generic"})
if CLIENT then
	language.Add("m16generic_ammo", "Bullets")
end

SWEP.PrintName = "Assault Rifle"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.
<color=green>[SECONDARY FIRE]</color> Launch a grenade.

Grenades will explode upon contact with surfaces.]]

SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "m16generic"

SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.2
SWEP.Primary.Damage = 12

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Secondary.Delay = 1.2
SWEP.Secondary.TakeAmmo = 6

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

local ShootSound = Sound("Weapon_M4A1.Single")
local NadeSound = Sound("weapons/grenade_launcher1.wav")
local MaxConeModifier = 0.4

local function CheckForNoAmmo(ent)
	if ent.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
		ent.needs_reload = true
	end
end

function SWEP:CanPrimaryAttack()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) > 0
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

	self:ShootEffects()
	self:EmitSound(ShootSound)

	if CLIENT then return end

	local bullet = {}
	bullet.Num = self.Primary.NumShots
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector(self.Primary.Cone + self.cone_modifier, self.Primary.Cone + self.cone_modifier, 0)
	bullet.Tracer = 1
	bullet.Force = 20
	bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.Ammo
	
	self.Owner:FireBullets(bullet)

	self.cone_modifier = math.min(MaxConeModifier, self.cone_modifier + 0.05)
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > self.Primary.DefaultClip then
		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end

	self.Owner:RemoveAmmo(1, self.Primary.Ammo)
	CheckForNoAmmo(self)
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:SecondaryAttack()
	-- not a typo, they use the same conditions
	if not self:CanPrimaryAttack() then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

	self:ShootEffects()
	self:EmitSound(ShootSound)

	if CLIENT then return end

	local nade = ents.Create("ent_impactgrenade")

	if not IsValid(nade) then return end

	nade:SetOwner(self.Owner)
	nade:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector() * 16))
	nade:SetAngles(self.Owner:EyeAngles())
	nade:Spawn()

	local phys = nade:GetPhysicsObject()
	if not IsValid(phys) then nade:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 2400
	phys:ApplyForceCenter(velocity)

	self.Owner:RemoveAmmo(math.Clamp(self.Secondary.TakeAmmo, 1, self.Owner:GetAmmoCount(self.Primary.Ammo)), self.Primary.Ammo)
	CheckForNoAmmo(self)
end

function SWEP:Reload()
	if not IsFirstTimePredicted() or self.Owner:GetAmmoCount(self.Primary.Ammo) >= self.Primary.DefaultClip or self.reloading then return end

	self:SendWeaponAnim(ACT_VM_RELOAD)

	self.reload_timer = CurTime() + self:SequenceDuration(ACT_VM_RELOAD)
	self.reloading = true
end]

function SWEP:Think()
	self.cone_modifier = math.max(0, self.cone_modifier - (FrameTime() / 10))

	if self.needs_reload then
		self.needs_reload = false
		self:Reload()
	end

	if self.reloading and self.reload_timer <= CurTime() then
		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end
end

function SWEP:Deploy()
	self.reloading = false
	self.reload_timer = 0
	self.cone_modifier = 0
	return self.BaseClass.Deploy(self)
end
