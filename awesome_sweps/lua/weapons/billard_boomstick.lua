local fuck = GESTURE_SLOT_ATTACK_AND_RELOAD

SWEP.PrintName = "Boomstick"
SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left click to blow down doors or people.\nRight click to launch a rocket."
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 60
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.SwayScale = 1
SWEP.DrawAmmo = true
SWEP.Slot = 3

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 18
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "SMG1_Grenade"
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 8
SWEP.Secondary.Automatic = false

local IsDoor = {
	["prop_door_rotating"] = true,
	["func_movelinear"] = true,
	["func_door"] = true,
	["func_door_rotating"] = true
}

function SWEP:ShouldDropOnDie()
	return true
end

function SWEP:ShootBullet(damage, num_bullets, aimcone)
	local bullet = {}
	bullet.Num 	= num_bullets
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector(aimcone, aimcone, 0)
	bullet.Tracer = 1
	bullet.Force = 200
	bullet.Damage = damage
	bullet.AmmoType = "Pistol"
	self.Owner:FireBullets(bullet)
	self:ShootEffects()
end

function SWEP:Deploy()
	self:SetHoldType("shotgun")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Owner:AnimRestartGesture(fuck, ACT_SHOTGUN_RELOAD_FINISH, true)
	return true
end

function SWEP:Reload()
	self.Weapon:DefaultReload(ACT_VM_DRAW)
	if (self.Weapon:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() > 0) or (self.Weapon:Clip2() < self.Secondary.ClipSize and self.Weapon:Ammo2() > 0) then
		self.Owner:AnimRestartGesture(fuck, ACT_SHOTGUN_RELOAD_FINISH, true)
		self:EmitSound(Sound("weapons/shotgun/shotgun_reload"..math.random(1, 3)..".wav"))
		self:SetNextPrimaryFire(CurTime() + 1)
		self:SetNextSecondaryFire(CurTime() + 1)
	end
end

function SWEP:PrimaryAttack()
	if (not self:CanPrimaryAttack()) then return end
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(true)
	end
	local trent = util.TraceLine(util.GetPlayerTrace(self.Owner)).Entity
	local trpos = util.TraceLine(util.GetPlayerTrace(self.Owner)).HitPos
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(false)
	end
	self:ShootBullet(20, 8, 0.08)
	self:TakePrimaryAmmo(1)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:EmitSound(Sound("weapons/xm1014/xm1014-1.wav"))
	self.Owner:ViewPunch(Angle(-2, 0, 0))
	if trent:GetPos():Distance(self.Owner:GetPos()) < 256 then
		if IsDoor[trent:GetClass()] then
			trent:Fire("Unlock", "", 0)
			trent:Fire("Open", "", 0)
			local sparks = EffectData()
			sparks:SetOrigin(trpos)
			util.Effect("cball_explode", sparks)
		end
	end
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.4)
end

function SWEP:SecondaryAttack()
	if (not self:CanSecondaryAttack()) then return end
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(true)
	end
	local trent = util.TraceLine(util.GetPlayerTrace(self.Owner)).Entity
	local trpos = util.TraceLine(util.GetPlayerTrace(self.Owner)).HitPos
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(false)
	end
	self:ShootEffects()
	self:TakeSecondaryAmmo(1)
	self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	self:EmitSound(Sound("weapons/rpg/rocketfire1.wav"))
	self.Owner:ViewPunch(Angle(-8, 0, 0))
	timer.Simple(self.Owner:GetPos():Distance(trpos) / 2048, function()
		if !IsValid(self) then return end
		local boom = EffectData()
		boom:SetOrigin(trpos)
		util.Effect("HelicopterMegaBomb", boom)
		util.BlastDamage(self, self.Owner, trpos, 256, 150)
		sound.Play("weapons/awp/awp1.wav", trpos)
		self:EmitSound(Sound("weapons/awp/awp1.wav"))
	end)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
end
