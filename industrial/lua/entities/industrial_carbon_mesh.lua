AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Carbon Mesh"
ENT.Spawnable = true
ENT.Model = "models/props_c17/playground_swingset_seat01a.mdl"
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
function ENT:PermaColor()
	return Color(40, 40, 40)
end
