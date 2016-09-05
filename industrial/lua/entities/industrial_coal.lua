AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Coal"
ENT.Spawnable = true
ENT.Model = "models/props_junk/rock001a.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Coal can be used to power coal engines or ground into coal dust."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaColor()
	return Color(60, 60, 60)
end
