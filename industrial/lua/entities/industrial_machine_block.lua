AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Machine Block"
ENT.Spawnable = true
ENT.Model = "models/hunter/blocks/cube05x05x05.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Machine blocks are used to make most simple machines."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
