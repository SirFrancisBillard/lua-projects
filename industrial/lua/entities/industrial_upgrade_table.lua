AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Upgrade Table"
ENT.Spawnable = true
ENT.Model = "models/props/CS_militia/wood_table.mdl"
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
	return "Upgrade tables allow you to upgrade your weapons and items at the cost of power."
end
function ENT:GetMaxStoredPower()
	return 20000
end
