AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Carbon Mesh"
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
	return "Carbon mesh can be compressed to create carbon plates."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaMaterial()
	return "models/props/cs_office/snowmana"
end
