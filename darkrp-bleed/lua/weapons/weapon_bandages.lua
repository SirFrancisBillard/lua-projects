AddCSLuaFile()

SWEP.Base = "weapon_sck_base"

SWEP.PrintName = "Bandage"
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = "Bandages can be used to stop bleeding and restore health."
SWEP.Instructions = "<color=green>[PRIMARY FIRE]</color> Use on yourself."

SWEP.Slot = 3
SWEP.SlotPos = 100

SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "bandages"

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "None"

SWEP.VElements = {
	["bandage"] = { type = "Model", model = "models/props/cs_office/Paper_towels.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.43, 4.143, 0), angle = Angle(-95.865, 7.394, -18.122), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["bandage"] = { type = "Model", model = "models/props/cs_office/Paper_towels.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.012, 2.647, -2.123), angle = Angle(-69.766, 5.291, 9.59), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:IsGood()
	return IsValid(self) and IsValid(self.Owner) and self.Owner:IsPlayer() and self.Owner:Alive() and IsValid(self.Owner:GetActiveWeapon()) and self.Owner:GetActiveWeapon():GetClass() == self.ClassName
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + 1)
	self.Using = false
end

function SWEP:CanPrimaryAttack()
	if self.Weapon:Clip1() <= 0 then
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:DefaultReload(ACT_VM_DRAW)
		return false
	end
	return true
end

function SWEP:PrimaryAttack()
	if self.Using then return end
	self.Using = true
	self:SendWeaponAnim(ACT_VM_THROW)
	timer.Simple(0.3, function()
		if not self:IsGood() then return end
		self:TakePrimaryAmmo(1)
		self.Owner:SetNWInt("Bleed", 0)
		self.Owner:SetNWEntity("BleedAttacker", self.Owner)
		self.Owner:SetNWEntity("BleedInflictor", self.Owner)
		self.Owner:SetHealth(math.min(self.Owner:Health() + 5, self.Owner:GetMaxHealth()))
		self:DefaultReload(ACT_VM_DRAW)
		self.Using = false
		if self:Ammo1() < 1 and SERVER then
			self.Owner:StripWeapon(self.ClassName)
		end
	end)
end

function SWEP:SecondaryAttack() end
