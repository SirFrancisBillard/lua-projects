AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Coal Dust"
ENT.Spawnable = true
ENT.Model = "models/props_junk/garbage_bag001a.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Coal dust is used solely to craft carbon mesh."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaMaterial()
	return "models/props_wasteland/concretewall066a"
end
function ENT:PermaColor()
	return Color(35, 35, 35)
end
