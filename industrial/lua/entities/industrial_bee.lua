AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Bee"
ENT.Spawnable = true
ENT.Model = "models/hunter/plates/plate.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "I feel as though Nicolas Cage would have something to say."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaColor()
	return Color(0, 0, 0)
end
