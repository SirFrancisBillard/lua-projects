AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Empty Missile Casing"
ENT.Spawnable = true
ENT.Model = "models/mechanics/solid_steel/box_beam_4.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Empty missile casings are used solely to make missiles."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
