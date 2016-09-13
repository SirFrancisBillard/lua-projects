SWEP.PrintName = "Car Bomb Defuser"
SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left click to defuse a car bomb.\nRight click to check if a car has a bomb."
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.UseHands = false
SWEP.ViewModelFOV = 60
SWEP.WorldModel = "models/weapons/w_hands.mdl"

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

function SWEP:CanSecondaryAttack()
	return (self:GetNextSecondaryFire() < CurTime())
end

function SWEP:CanPrimaryAttack()
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	self.Owner:LagCompensation(false)
	return trent.HasCarBombPlanted and IsValid(trent) and trent:IsVehicle() and (self.Owner:GetPos():Distance(trent:GetPos()) < 512)
end

function SWEP:Deploy()
	self:SetHoldType("normal")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:Reload() end

function SWEP:SecondaryAttack()
	if (not self:CanSecondaryAttack()) then return end
	self:SetNextSecondaryFire(CurTime() + 0.5)
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	self.Owner:LagCompensation(false)
	if trent.HasCarBombPlanted then
		self:EmitSound(Sound("buttons/blip1.wav"))
		if SERVER then
			self.Owner:ChatPrint("Car bomb detected!")
		end
	end
end

function SWEP:PrimaryAttack()
	if (not self:CanPrimaryAttack()) then return end
	self:SetNextPrimaryFire(CurTime() + 3)
	if SERVER then
		self.Owner:ChatPrint("Defusing...")
	end
	self:EmitSound(Sound("weapons/c4/c4_disarm.wav"))
	timer.Simple(3, function()
		if self:CanPrimaryAttack() and IsValid(self.Owner) then
			self:EmitSound(Sound("weapons/c4/c4_disarm.wav"))
			self.Owner:LagCompensation(true)
			local trent = self.Owner:GetEyeTrace().Entity
			self.Owner:LagCompensation(false)
			trent.HasCarBombPlanted = nil
			if SERVER then
				self.Owner:ChatPrint("Bomb defused!")
				self.Owner:StripWeapon(self.ClassName)
			end
		else
			if SERVER then
				self.Owner:ChatPrint("Defusing failed!")
			end
		end
	end)
end
