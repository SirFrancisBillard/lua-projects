----------------------------------------
--Name: "billard_blindfold.lua"
--By: "Sir Francis Billard"
----------------------------------------

SWEP.PrintName = "Blindfold"
SWEP.Base = "billard_base"
SWEP.Category = "Other"

SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left click to blindfold someone."

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Pin"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["v_cloth"] = { type = "Model", model = "models/props_vehicles/tire001c_car.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(-0.721, 2.493, -1.39), angle = Angle(-7.842, -10.799, 0), size = Vector(0.324, 0.324, 0.324), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["w_cloth"] = { type = "Model", model = "models/props_vehicles/tire001c_car.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.194, 4.909, -0.343), angle = Angle(0.884, -13.28, 3.138), size = Vector(0.324, 0.324, 0.324), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.DrawAmmo = false

SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip  = -1

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip  = -1

function SWEP:PrimaryAttack()
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	self.Owner:LagCompensation(false)
	local function isbadman()
		return !trent:IsPlayer() or !IsValid(trent) or !trent:Distance(self.Owner:GetPos()) < 128
	end
	local function printnearby(text)
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 512)) do
			if v:IsPlayer() and IsValid(v) and SERVER then
				v:ChatPrint(self.Owner:Nick().." ")
			end
		end
	end
	if isbadman() then return end
	timer.Simple(1, function()
		if isbadman() then return end
		printnearby("starts to wrap the blindfold around "..trent:Nick().."'s eyes.")
	end)
	timer.Simple(1.5, function()
		if isbadman() then return end
		printnearby("does a simple knot.")
	end)
	timer.Simple(2, function()
		if isbadman() then return end
		printnearby("doubles the knot.")
	end)
	timer.Simple(3, function()
		if isbadman() then return end
		printnearby("finishes blindfolding "..trent:Nick())
		if SERVER then
			trent:Give("weapon_bound")
			trent:ConCommand("use weapon_bound")
			self.Owner:StripWeapon(self.ClassName)
		end
	end)
end

function SWEP:SecondaryAttack() end
