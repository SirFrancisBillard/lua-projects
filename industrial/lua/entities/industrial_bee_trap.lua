AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Bee Trap"
ENT.Spawnable = true
ENT.Model = "models/props_wasteland/gaspump001a.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Bee traps will catch bees that can be extracted with the use key."
end
function ENT:MinerData()
	return true, {"industrial_bee"}, false, 30, 5
end
