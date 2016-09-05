AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Miner"
ENT.Spawnable = true
ENT.Model = "models/props_industrial/winch_stern.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Miners will mine materials when given power."
end
function ENT:MinerData()
	return true, {"industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal", "industrial_coal", "industrial_coal", "industrial_coal", "industrial_zinc", "industrial_zinc", "industrial_gold"}, true, 30, 20
end
