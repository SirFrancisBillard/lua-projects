AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Glass"
ENT.Spawnable = true
ENT.Model = "models/props_phx/construct/glass/glass_plate1x1.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Glass can be used to craft lasers, gardens, and advanced solar panels."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
