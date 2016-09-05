AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Artificial Garden"
ENT.Spawnable = true
ENT.Model = "models/props/cs_office/plant01.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Artificial gardens will grow plants when given power."
end
function ENT:MinerData()
	return true, {"industrial_foliage", "industrial_foliage", "industrial_foliage", "industrial_wood", "industrial_wood", "industrial_wood", "industrial_wood", "industrial_flower"}, true, 20, 5
end
