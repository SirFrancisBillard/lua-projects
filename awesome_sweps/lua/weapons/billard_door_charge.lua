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

SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.PlantedDoor = "None"

local IsDoor = {
	["prop_door_rotating"] = true,
	["func_movelinear"] = true,
	["func_door"] = true,
	["func_door_rotating"] = true
}

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "BombPlanted")
	self:NetworkVar("Bool", 1, "BombType")
	self:NetworkVar("Int", 0, "ReloadSpamTime")
end

function SWEP:Detonate()
	if IsEntity(self.PlantedDoor) and IsValid(self.PlantedDoor) and self:GetBombPlanted() then
		self.Owner:StripWeapon(self.ClassName)
		SafeRemoveEntity(self.SlamProp)
		self.SlamProp = nil
		local boom = EffectData()
		boom:SetOrigin(self.PlantedDoor:GetPos())
		util.Effect("HelicopterMegaBomb", boom)
		local door = self.PlantedDoor
		local matthew = door:GetMaterial() or ""
		if self:GetBombType() then
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
	if self:GetBombPlanted() then
		self.Weapon:SendWeaponAnim(ACT_SLAM_DETONATOR_IDLE)
	else
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
	return true
end

function SWEP:Reload()
	if (self:GetReloadSpamTime() < CurTime()) then
		self:SetReloadSpamTime(CurTime() + 0.5)
		self:EmitSound(Sound("weapons/c4/c4_beep1.wav"))
		self:SetBombType(not self:GetBombType())
		self.Owner:ChatPrint(self:GetBombType() and "Bomb type switched to destroy door." or "Bomb type switched to open door.")
	end
end

function SWEP:CanSecondaryAttack()
	return self:GetBombPlanted() and IsEntity(self.PlantedDoor) and IsValid(self.PlantedDoor)
end

function SWEP:CanPrimaryAttack()
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	self.Owner:LagCompensation(false)
	return !self:GetBombPlanted() and IsValid(trent) and IsDoor[trent:GetClass()] and self.Owner:GetPos():Distance(trent:GetPos()) < 256
end

function SWEP:SecondaryAttack()
	if (not self:CanSecondaryAttack()) then return end
	self:Detonate()
end

function SWEP:PrimaryAttack()
	if (not self:CanPrimaryAttack()) or (not SERVER) then return end
	self:SetNextPrimaryFire(CurTime() + 5)
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	local trpos = self.Owner:GetEyeTrace().HitPos
	local trnorm = self.Owner:GetEyeTrace().HitNormal
	self.Owner:LagCompensation(false)
	self.Weapon:SendWeaponAnim(ACT_SLAM_STICKWALL_ATTACH)
	timer.Simple(self:SequenceLength() + 0.1, function()
		if IsValid(self.Owner) and IsValid(self.Weapon) then
			self.PlantedDoor = trent
			self:EmitSound(Sound("weapons/c4/c4_plant.wav"))
			self.SlamProp = ents.Create("prop_physics")
			self.SlamProp:SetModel("models/weapons/w_slam.mdl")
			self.SlamProp:SetAngles(trnorm:Angle() + Angle(90, 0, 0))
			self.SlamProp:SetPos(trpos + (self:GetAngles() * 6))
			self.SlamProp:Spawn()
			constraint.Weld(self.PlantedDoor, self.SlamProp, 0, 0, 0, true, false)
			self:SetBombPlanted(true)
			self.Weapon:SendWeaponAnim(ACT_SLAM_DETONATOR_IDLE)
		end
	end)
end
