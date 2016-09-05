AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Macerator"
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
	return "Some items can be ground down into more usable materials."
end
function ENT:RefineryData()
	return true, {"industrial_coal", "industrial_metal", "industrial_foliage"}, 1, {"industrial_coal_dust", "industrial_sand", "industrial_biofuel"}, 10, 20, true
end
