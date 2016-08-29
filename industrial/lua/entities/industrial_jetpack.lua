AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Jetpack"
ENT.Spawnable = true
ENT.Model = "models/thrusters/jetpack.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Jetpacks allow the user to fly and can be equipped with the use key."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
if SERVER then
	function ENT:OnEntityUsed(ply)
		if (not ply:GetNWBool("IsWearingJetpack")) then
			SafeRemoveEntity(self)
			ply:SetNWBool("IsWearingJetpack", true)
		else
			ply:ChatPrint("You are already wearing a jetpack!")
		end
	end
end
