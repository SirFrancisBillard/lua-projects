----------------------------------------
--Name: "battering_ram.lua"
--By: "Sir Francis Billard"
----------------------------------------

SWEP.PrintName = "Battering Ram"
SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left or right click to knock down a door."
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 60
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.SwayScale = 1
SWEP.DrawAmmo = false
SWEP.Slot = 4

SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

local IsDoor = {
	["prop_door_rotating"] = true,
	["func_movelinear"] = true,
	["func_door"] = true,
	["func_door_rotating"] = true
}

function SWEP:Deploy()
	self:SetHoldType("rpg")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:CanPrimaryAttack()
	return self:GetNextPrimaryFire() < CurTime()
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(true)
	end
	local trent = util.TraceLine(util.GetPlayerTrace(self.Owner)).Entity
	local trpos = util.TraceLine(util.GetPlayerTrace(self.Owner)).HitPos
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(false)
	end
	if IsDoor[trent:GetClass()] and trent:GetPos():Distance(self.Owner:GetPos()) < 80 then
		self:EmitSound(Sound("physics/wood/wood_solid_impact_hard"..math.random(1, 3)..".wav"))
		if SERVER then
			trent:Fire("Unlock", "", 0)
			trent:Fire("Open", "", 0)
		end
	else
		self:EmitSound(Sound("weapons/iceaxe/iceaxe_swing1.wav"))
	end
	self.Owner:ViewPunch(Angle(40, 0, 0))
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Weapon:SetNextPrimaryFire(CurTime() + 2)
end
