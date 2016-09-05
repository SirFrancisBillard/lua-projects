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

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip -1
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip -1
SWEP.Secondary.Automatic = true

local LASER = Material("cable/redlaser")

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "Charge")
	self:NetworkVar("Int", 1, "DoDamage")
	self:NetworkVar("Int", 2, "LaserColorR")
	self:NetworkVar("Int", 3, "LaserColorG")
	self:NetworkVar("Int", 4, "LaserColorB")
	self:NetworkVar("Int", 5, "ReloadSpamTime")
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
	self:SetDoDamage(5)
	self:SetCharge(100)
	self:SetLaserColorR(255)
	self:SetLaserColorG(0)
	self:SetLaserColorB(0)
	self:SetReloadSpamTime(CurTime() + 1)
end

function SWEP:IsActive()
	return (self:GetOwner():KeyDown(IN_ATTACK) and IsValid(self:GetOwner():GetActiveWeapon()) and (self:GetOwner():GetActiveWeapon():GetClass() == self.ClassName) and (self:GetCharge() > 0))
end

function SWEP:ShootBullet()
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector() -- Dir of bullet
	bullet.Spread = Vector(0, 0, 0)	-- Aim Cone
	bullet.Tracer = 1337 -- Show a tracer on every x bullets
	bullet.Force = 0 -- Amount of force to give to phys objects
	bullet.Damage = self:GetDoDamage()
	bullet.AmmoType = "Pistol"
	self.Owner:FireBullets(bullet)
	self:ShootEffects()
end

if SERVER then
	function SWEP:Reload()
		if (self:GetReloadSpamTime() <= CurTime()) then
			self.Owner:ChatPrint("Charge: "..self:GetCharge())
			self:SetReloadSpamTime(CurTime() + 1)
		end
	end

	function SWEP:CanSecondaryAttack()
		return false
	end
	
	function SWEP:SecondaryAttack() end
	
	function SWEP:CanPrimaryAttack()
		return ((self:GetCharge() > 0) and (self:GetNextPrimaryFire() < CurTime()))
	end
	
	function SWEP:PrimaryAttack()
		if self:CanPrimaryAttack() then
			self:SetCharge(math.Clamp(self:GetCharge() - 1, 0, self:GetCharge()))
			self:SetNextPrimaryFire(CurTime() + 0.1)
			self:ShootBullet()
		end
	end
end
if CLIENT then
	function SWEP:Setup(ply)
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
	end

	function SWEP:Initialize()
		self:Setup(self:GetOwner())
	end
	
	function SWEP:Deploy(ply)
		self:Setup(self:GetOwner())
	end

	function SWEP:ViewModelDrawn()
		if self:IsActive() and self.VM then
		render.SetMaterial(LASER)
			render.DrawBeam(self.VM:GetAttachment(self.Attach).Pos, self:GetOwner():GetEyeTrace().HitPos, 2, 0, 12.5, Color(255, 0, 0, 255))
		end
	end
	
	function SWEP:DrawWorldModel()
		self.Weapon:DrawModel()
		if self:IsActive() and self.WM then
		render.SetMaterial(LASER)
			local posang = self.WM:GetAttachment(self.WAttach)
			if not posang then self.WM = nil ErrorNoHalt("Laser Rifle: Attachment lost, did they change model or something?\n") return end
			render.DrawBeam(posang.Pos + posang.Ang:Forward() * 10 + posang.Ang:Up() * 4.4 + posang.Ang:Right(), self:GetOwner():GetEyeTrace().HitPos, 2, 0, 12.5, self:GetLaserColor())
		end
	end
end
