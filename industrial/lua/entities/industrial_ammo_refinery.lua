AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Ammo Refinery"
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
	return "Ammo refineries can turn brass and gunpowder into ammo."
end
function ENT:RefineryData()
	return true, {"industrial_brass", "industrial_gunpowder"}, 2, "industrial_ammo", 20, 20, false
end
