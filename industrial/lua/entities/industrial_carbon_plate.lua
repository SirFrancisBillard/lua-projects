AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Carbon Plate"
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
	return "Carbon plates are used solely to craft nano suits."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaColor()
	return Color(30, 30, 30)
end
