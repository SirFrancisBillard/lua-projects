AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Apiary"
ENT.Spawnable = true
ENT.Model = "models/props/CS_militia/furnace01.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Apiaries can harvest honey comb from bees when given power."
end
function ENT:RefineryData()
	return true, {"industrial_bee"}, 1, "industrial_honey_comb", 30, 5, false
end