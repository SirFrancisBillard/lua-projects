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
	return Color(self:GetLaserColorR(), self:GetLaserColorG(), self:GetLaserColorB())
end
function SWEP:SetLaserColor(color)
	self:SetLaserColorR(color.r)
	self:SetLaserColorG(color.g)
	self:SetLaserColorB(color.b)
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
	local ply = self.Owner
	local LASER = Material("cable/redlaser")
	if ply.GetViewModel and ply:GetViewModel():IsValid() then
		local attachmentIndex = ply:GetViewModel():LookupAttachment("muzzle")
		if attachmentIndex == 0 then attachmentIndex = ply:GetViewModel():LookupAttachment("1") end
		if LocalPlayer():GetAttachment(attachmentIndex) then
			self.VM = ply:GetViewModel()
			self.Attach = attachmentIndex
		end
	end
	if ply:IsValid() then
		local attachmentIndex = ply:LookupAttachment("anim_attachment_RH")
		if ply:GetAttachment(attachmentIndex) then
			self.WM = ply
			self.WAttach = attachmentIndex
		end
	end
	function SWEP:ViewModelDrawn()
		if ply:KeyDown(IN_ATTACK) and self.VM then
	        	render.SetMaterial( LASER )
			render.DrawBeam(self.VM:GetAttachment(self.Attach).Pos, self:GetOwner():GetEyeTrace().HitPos, 2, 0, 12.5, self:GetLaserColor())
	    	end
	end
end
