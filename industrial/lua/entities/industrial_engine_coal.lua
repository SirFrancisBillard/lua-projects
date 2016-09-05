AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Coal Engine"
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
	return "Coal engines generate power at a normal rate, but require coal to function."
end
function ENT:EngineData()
	return true, {"industrial_coal"}, {20}
end
function ENT:PowerGenerationRate()
	return 20
end
