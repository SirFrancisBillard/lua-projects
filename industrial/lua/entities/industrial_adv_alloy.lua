AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Advanced Alloy"
ENT.Spawnable = true
ENT.Model = "models/mechanics/solid_steel/i_beam_4.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Advanced alloy is a high tier metal used to craft rockets."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
