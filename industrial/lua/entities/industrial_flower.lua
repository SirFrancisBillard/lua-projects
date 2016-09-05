AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Flower"
ENT.Spawnable = true
ENT.Model = "models/props/cs_office/Snowman_arm.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Flowers can be used to attract and keep bees."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
