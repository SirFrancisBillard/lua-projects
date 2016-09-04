AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Crafting Table"
ENT.Spawnable = true
ENT.Model = "models/props/CS_militia/table_kitchen.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:Recipes()
	return 0
end
function ENT:HelpText()
	return "Crafting tables are used to forge items such as jetpacks, lasers, and higher tier materials."
end
function ENT:GetMaxStoredPower()
	return 10000
end
