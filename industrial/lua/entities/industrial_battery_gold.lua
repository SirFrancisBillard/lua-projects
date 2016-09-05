AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Golden Battery"
ENT.Spawnable = true
ENT.Model = "models/Items/car_battery01.mdl"
function ENT:IndustrialType()
	return "bat"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Golden batteries can carry absolutely enourmous amounts of power."
end
function ENT:GetMaxStoredPower()
	return 500000
end
function ENT:PermaMaterial()
	return "models/props/cs_office/snowmana"
end
function ENT:PermaColor()
	return Color(255, 255, 100)
end
