AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Royal Crucible Engine"
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
	return "Royal crucible engines run solely on gold, and deliver extremely high amounts of power."
end
function ENT:EngineData()
	return true, {"industrial_gold"}, {60}
end
function ENT:PowerGenerationRate()
	return 200
end
