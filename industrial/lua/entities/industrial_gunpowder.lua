AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Gunpowder"
ENT.Spawnable = true
ENT.Model = "models/props_c17/woodbarrel001.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Gunpowder can be used to craft ammo and simple explosives."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end