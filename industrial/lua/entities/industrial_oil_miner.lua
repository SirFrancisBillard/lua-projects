AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Oil Well"
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
	return "Oil wells will generate oil when given enough power. Harvested oil can be extracted from the well with the use key."
end
function ENT:MinerData()
	return true, {"industrial_oil"}, false, 60, 10
end
