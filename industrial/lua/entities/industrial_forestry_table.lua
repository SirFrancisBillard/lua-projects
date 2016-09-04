AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Forestry Table"
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
function ENT:HelpText()
	return "Forestry tables are used to make items to farm."
end
function ENT:GetMaxStoredPower()
	return 8000
end
