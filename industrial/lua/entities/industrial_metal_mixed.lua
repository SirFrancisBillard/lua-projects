AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Mixed Metal"
ENT.Spawnable = true
ENT.Model = "models/Items/item_item_crate_chunk02.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Mixed metal is a blend of iron, copper, lead, gold, and zinc. It can be compressed into advanced alloy."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaMaterial()
	return "models/props_pipes/GutterMetal01a"
end
