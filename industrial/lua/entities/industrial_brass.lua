AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Brass"
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
	return "Brass is an alloy made from metal and zinc that can be used to make ammo."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaMaterial()
	return "models/props_pipes/pipemetal001a"
end
function ENT:PermaColor()
	return Color(255, 200, 0)
end
