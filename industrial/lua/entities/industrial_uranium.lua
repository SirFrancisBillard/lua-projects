AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Uranium"
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
	return "Who's ranium?"
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaMaterial()
	return "models/debug/debugwhite"
end
function ENT:PermaColor()
	return Color(0, 255, 0)
end
