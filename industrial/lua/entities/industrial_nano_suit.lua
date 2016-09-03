AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Nano Suit"
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
	return "Nano suits offer a great amount of protection from most sources and can be upgraded at an upgrade station."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
if SERVER then
	function ENT:OnEntityUsed(ply)
		if (not ply:GetNWBool("IsWearingNanoSuit")) then
			SafeRemoveEntity(self)
			ply:SetNWBool("IsWearingNanoSuit", true)
		else
			ply:ChatPrint("You are already wearing a nano suit!")
		end
	end
end
