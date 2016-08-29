AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Metal Mine"
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
	return "Metal mines will mine metals when given power."
end
function ENT:MinerData()
	return true, {"industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_zinc", "industrial_zinc", "industrial_zinc", "industrial_gold"}, true, 80, 20
end
