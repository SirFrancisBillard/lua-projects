----------------------------------------
--Name: "door_charge.lua"
--By: "Sir Francis Billard"
----------------------------------------

SWEP.PrintName = "Door Charge"
SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left click to plant charge.\nRight click to detonate.\nReload to change bomb type."
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 60
SWEP.WorldModel = "models/weapons/w_slam.mdl"

SWEP.SwayScale = 1
SWEP.DrawAmmo = false
SWEP.Slot = 4

SWEP.BombPlanted = false
SWEP.PlantedDoor = "None"
SWEP.BombType = true
SWEP.ReloadSpamTime = 0

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

function SWEP:Detonate()
	if IsEntity(self.PlantedDoor) and IsValid(self.PlantedDoor) and self.BombPlanted then
		self.Owner:StripWeapon(self.ClassName)
		SafeRemoveEntity(self.SlamProp)
		self.SlamProp = nil
		local boom = EffectData()
		boom:SetOrigin(self.PlantedDoor:GetPos())
		util.Effect("HelicopterMegaBomb", boom)
		local door = self.PlantedDoor
		local matthew = door:GetMaterial() or ""
		if self.BombType then
			door:SetMaterial("Models/effects/vol_light001")
		end
		self.PlantedDoor = "None"
		door:EmitSound(Sound("weapons/awp/awp1.wav"))
		if self.BombType then
			door:SetPos(door:GetPos() - Vector(0, 0, 1000))
			timer.Simple(30, function()
				if IsValid(door) then
					door:SetMaterial(matthew or "")
					door:SetPos(door:GetPos() + Vector(0, 0, 1000))
				end
			end)
		else
			door:Fire("Unlock")
			door:Fire("Open")
		end
	end
end

function SWEP:Holster()
	if IsEntity(self.SlamProp) then
		SafeRemoveEntity(self.SlamProp)
	end
	self.SlamProp = nil
	return true
end

function SWEP:Deploy()
	self:SetHoldType("slam")
	if self.BombPlanted then
		self.Weapon:SendWeaponAnim(ACT_SLAM_DETONATOR_IDLE)
	else
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
	return true
end

function SWEP:Reload()
	if self.ReloadSpamTime < CurTime() then
		self.ReloadSpamTime = CurTime() + 0.5
		self:EmitSound(Sound("weapons/c4/c4_beep1.wav"))
		self.BombType = !self.BombType
		self.Owner:ChatPrint(self.BombType and "Bomb type switched to destroy door." or "Bomb type switched to open door.")
	end
end

function SWEP:CanSecondaryAttack()
	return self.BombPlanted and IsEntity(self.PlantedDoor) and IsValid(self.PlantedDoor)
end

function SWEP:CanPrimaryAttack()
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	self.Owner:LagCompensation(false)
	return !self.BombPlanted and IsValid(trent) and IsDoor[trent:GetClass()] and self.Owner:GetPos():Distance(trent:GetPos()) < 256
end

function SWEP:SecondaryAttack()
	if !self:CanSecondaryAttack() then return end
	self:Detonate()
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() or !SERVER then return end
	self:SetNextPrimaryFire(CurTime() + 5)
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	local trpos = self.Owner:GetEyeTrace().HitPos
	local trnorm = self.Owner:GetEyeTrace().HitNormal
	self.Owner:LagCompensation(false)
	self.Weapon:SendWeaponAnim(ACT_SLAM_STICKWALL_ATTACH)
	timer.Simple(1, function()
		if IsValid(self.Owner) and IsValid(self.Weapon) then
			self:EmitSound(Sound("weapons/c4/c4_plant.wav"))
			self.SlamProp = ents.Create("prop_physics")
			self.SlamProp:SetModel("models/weapons/w_slam.mdl")
			self.SlamProp:SetPos(trpos)
			self.SlamProp:SetAngles(trnorm:Angle() + Angle(90, 0, 0))
			self.SlamProp:Spawn()
			self.PlantedDoor = trent
			constraint.Weld(self.PlantedDoor, self.SlamProp, 0, 0, 0, true, false)
			self.BombPlanted = true
			self.Weapon:SendWeaponAnim(ACT_SLAM_DETONATOR_IDLE)
		end
	end)
end
