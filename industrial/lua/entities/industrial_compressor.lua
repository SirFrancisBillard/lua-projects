AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Compressor"
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
	return "Some items can be compressed into more usable materials."
end
function ENT:RefineryData()
	return true, {"industrial_metal_mixed", "industrial_carbon_mesh", "industrial_honey_comb"}, 1, {"industrial_adv_alloy", "industrial_carbon_plate", "industrial_honey"}, 10, 40, true
end
