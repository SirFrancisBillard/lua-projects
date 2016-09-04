AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Honey"
ENT.Spawnable = true
ENT.Model = "models/props_lab/jar01b.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Honey can be used to make medicine and can be smelted into caramel."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaColor()
	return Color(255, 195, 0)
end
