AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Water Mill"
ENT.Spawnable = true
ENT.Model = "models/props_interiors/Radiator01a.mdl"
function ENT:IndustrialType()
	return "gen"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Water mills can generate a lot of cheap power when placed in water. The amount of power it generates is based on how submerged it is."
end
function ENT:CanGeneratePower()
	return (self:WaterLevel() > 0)
end
function ENT:PowerGenerationRate()
	return 5 * self:WaterLevel()
end
