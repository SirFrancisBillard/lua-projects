----------------------------------------
--Name: "quantum_manipulator.lua"
--By: "Sir Francis Billard"
----------------------------------------

SWEP.PrintName = "Quantum Manipulator"
SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left click to disorient a target.\nRight click to blast targets upwards.\nReload to give yourself a temporary speed boost."
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 60
SWEP.WorldModel = "models/weapons/w_irifle.mdl"

SWEP.SwayScale = 1
SWEP.DrawAmmo = false
SWEP.Slot = 2
SWEP.ReloadSpamTime = 0

SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

function SWEP:CanSecondaryAttack()
	return self:GetNextSecondaryFire() < CurTime()
end

function SWEP:CanPrimaryAttack()
	return self:GetNextPrimaryFire() < CurTime()
end

function SWEP:ShootBullet(damage, num_bullets, aimcone)
	local bullet = {}
	bullet.Num = num_bullets
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector(aimcone, aimcone, 0)
	bullet.Tracer = 1
	bullet.Force = 1000
	bullet.Damage = damage
	bullet.AmmoType = "Pistol"
	bullet.Callback = function(atk, tr, dmg)
		if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
			tr.Entity:SetEyeAngles(AngleRand())
		end 
	end
	self.Owner:FireBullets(bullet)
	self:ShootEffects()
end

function SWEP:Deploy()
	self:SetHoldType("ar2")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:Reload()
	if self.ReloadSpamTime < CurTime() then
		self:EmitSound(Sound("weapons/357/357_spin1.wav"))
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		local OldWalkSpeed = self.Owner:GetWalkSpeed()
		local OldRunSpeed = self.Owner:GetRunSpeed()
		self.Owner:SetWalkSpeed(self.Owner:GetWalkSpeed() * 1.5)
		self.Owner:SetRunSpeed(self.Owner:GetRunSpeed() * 1.5)
		timer.Simple(5, function()
			if IsValid(self.Owner) then
				self.Owner:SetWalkSpeed(OldWalkSpeed)
				self.Owner:SetRunSpeed(OldRunSpeed)
				self:EmitSound(Sound("garrysmod/content_downloaded.wav"))
			end
		end)
		self.ReloadSpamTime = CurTime() + 15
		self:SetNextPrimaryFire(CurTime() + 0.5)
	end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end
	self:ShootBullet(25, 1, 0)
	self:SetNextPrimaryFire(CurTime() + 0.5)
	self:EmitSound(Sound("weapons/mp5navy/mp5-1.wav"))
end

function SWEP:SecondaryAttack()
	if !self:CanSecondaryAttack() then return end
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(true)
	end
	local trent = util.TraceLine(util.GetPlayerTrace(self.Owner)).Entity
	local trpos = util.TraceLine(util.GetPlayerTrace(self.Owner)).HitPos
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(false)
	end
	self:EmitSound(Sound("weapons/scout/scout_fire-1.wav"))
	self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	local boom = EffectData()
	boom:SetOrigin(trpos)
	util.Effect("cball_explode", boom)
	for k, v in pairs(ents.FindInSphere(trpos, 128)) do
		if IsValid(v) and v:IsPlayer() then
			v:SetVelocity(Vector(0, 0, 500))
		end
	end
	self:SetNextSecondaryFire(CurTime() + 2)
	self:SetNextPrimaryFire(CurTime() + 0.5)
end
