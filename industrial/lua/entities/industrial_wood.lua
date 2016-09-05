AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Wood"
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
	return "Wood can be used to make forestry machines."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
