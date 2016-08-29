AddCSLuaFile()

SWEP.PrintName = "Laser Rifle"
SWEP.Category = "Industrial Weapons"
SWEP.Instructions = "Deals heavy ranged damage.\nCan be charged at a charging station."

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.UseHands = true

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "Charge")
	self:NetworkVar("Int", 1, "DoDamage")
	self:NetworkVar("Int", 2, "LaserColorR")
	self:NetworkVar("Int", 3, "LaserColorG")
	self:NetworkVar("Int", 4, "LaserColorB")
end
function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
end
function SWEP:GetLaserColor()
	return Color(self:GetLaserColorR(), self:GetLaserColorG(), self:GetLaserColorb())
end
function SWEP:Initialize()
	self:SetHoldType("ar2")
	self:SetDoDamage(10)
	self:SetCharge(100)
	self:SetLaserColorR(255)
	self:SetLaserColorG(0)
	self:SetLaserColorB(0)
end
if SERVER then
	function SWEP:Reload()
		self.Owner:ChatPrint("Charge: "..self:GetCharge())
	end
	function SWEP:CanSecondaryAttack()
		return false
	end
	function SWEP:SecondaryAttack() end
	function SWEP:CanPrimaryAttack()
		return (self:GetCharge() > 0) and (self:GetNextPrimaryFire() < CurTime())
	end
	function SWEP:PrimaryAttack()
		self:SetNextPrimaryFire(CurTime() + 0.2)
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
end
if CLIENT then

end
