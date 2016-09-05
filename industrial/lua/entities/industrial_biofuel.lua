AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Biofuel"
ENT.Spawnable = true
ENT.Model = "models/props_junk/gascan001a.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Biofuel can be used to power biofuel engines."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:ExplodesAfterDamage()
	return 50
end
