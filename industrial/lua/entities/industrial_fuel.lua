AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Fuel Can"
ENT.Spawnable = true
ENT.Model = "models/props_phx/construct/metal_plate1.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Fuel can be used with jetpacks or missiles, as well as being three times better at powering combustion engines compared to oil."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
