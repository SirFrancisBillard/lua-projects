AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Combustion Engine"
ENT.Spawnable = true
ENT.Model = "models/props_c17/TrapPropeller_Engine.mdl"
function ENT:IndustrialType()
	return "gen"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Combustion engines generate power very quickly without needing water or sun, at the cost of requiring oil or fuel to function."
end
function ENT:EngineData()
	return true, {"industrial_oil", "industrial_fuel"}, {30, 90}
end
function ENT:PowerGenerationRate()
	return 25
end
