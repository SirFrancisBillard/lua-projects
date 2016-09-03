AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Biofuel Engine"
ENT.Spawnable = true
ENT.Model = "models/props_vehicles/generatortrailer01.mdl"
function ENT:IndustrialType()
	return "gen"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Biofuel engines can generate power quickly with foliage or biofuel."
end
function ENT:EngineData()
	return true, {"industrial_biofuel", "industrial_foliage"}, {40, 5}
end
function ENT:PowerGenerationRate()
	return 25
end
