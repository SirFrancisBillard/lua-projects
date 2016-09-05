AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Oil"
ENT.Spawnable = true
ENT.Model = "models/props_c17/oildrum001.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Oil is an extremely useful resource that can be refined into fuel or used in a combustion engine."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
