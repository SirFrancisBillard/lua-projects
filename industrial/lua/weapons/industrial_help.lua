AddCSLuaFile()

SWEP.PrintName = "Help"
SWEP.Category = "Industrial Weapons"
SWEP.Instructions = "Click on an item from Industrial Mod to learn more about it and what it's used for."

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1

SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.UseHands = true

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:SecondaryAttack() end

function SWEP:PrimaryAttack()
	local ply = self.Owner
	if (ply:IsPlayer()) then
		ply:LagCompensation(true)
	end
	local tr = ply:GetEyeTrace()
	if IsValid(tr.Entity) and (tr.Entity.HelpText != nil) then
		ply:ChatPrint(tr.Entity:HelpText())
	end
	if (ply:IsPlayer()) then
		ply:LagCompensation(false)
	end
end
