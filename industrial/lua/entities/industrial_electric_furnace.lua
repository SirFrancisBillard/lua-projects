AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Electric Furnace"
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
	return "Some items can be smelted into more useful materials."
end
function ENT:RefineryData()
	return true, {"industrial_sand", "industrial_honey", "industrial_cured_plate"}, 1, {"industrial_glass", "industrial_caramel", "industrial_quantum_plate"}, 10, 20, false
end
