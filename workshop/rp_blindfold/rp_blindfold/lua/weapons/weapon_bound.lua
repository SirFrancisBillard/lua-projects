----------------------------------------
--Name: "billard_blindfold.lua"
--By: "Sir Francis Billard"
----------------------------------------

SWEP.PrintName = "Bound"
SWEP.Base = "billard_base"
SWEP.Category = "Other"

SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "You are bound.\nLeft click to escape."

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {}
SWEP.VElements = {}
SWEP.WElements = {
	["w_blind"] = { type = "Model", model = "models/props_vehicles/tire001c_car.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(3.194, 0.74, 0.201), angle = Angle(-3.392, 5.762, 5.005), size = Vector(0.324, 0.409, 0.324), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.DrawAmmo = false

SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip  = -1

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip  = -1

function SWEP:Holster()
	return false
end

function SWEP:CanPrimaryAttack()
	return self:GetNextPrimaryFire() < CurTime()
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:SecondaryAttack() end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 61)
	timer.Simple(math.random(40, 60), function()
		local he = self.Owner
		local me = self
		if !IsValid(he) or !IsValid(me) then return end
		if SERVER then
			he:ConCommand([[pp_texturize ""]])
			he:StripWeapon(me.ClassName)
		end
		he:PrintMessage(HUD_PRINTCENTER, "You have escaped from the bound!")
		he.IsBlindFolded = nil
	end)
end

function SWEP:Equip(NewOwner)
	if !NewOwner:IsPlayer() then return end
	if SERVER then
		NewOwner:ConCommand("use "..self.ClassName)
		NewOwner:ConCommand([[pp_texturize "models/rendertarget"]])
	end
	NewOwner:PrintMessage(HUD_PRINTCENTER, "You are bound. Left click to escape.")
	NewOwner.IsBlindFolded = true
end
