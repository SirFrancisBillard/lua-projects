AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Foliage"
ENT.Spawnable = true
ENT.Model = "models/props/de_inferno/fountain_bowl_p10.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Foliage can be ground into biofuel."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end