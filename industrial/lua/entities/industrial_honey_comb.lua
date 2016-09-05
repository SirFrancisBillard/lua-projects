AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Honey Comb"
ENT.Spawnable = true
ENT.Model = "models/noesis/donut.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Honey comb can be compressed into honey."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaMaterial()
	return "models/antlion/antlion_innards"
end
function ENT:PermaColor()
	return Color(255, 195, 0)
end
