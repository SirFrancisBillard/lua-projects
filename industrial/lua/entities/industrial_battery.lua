AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Battery"
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
	return "Batteries are the most efficient way of storing and transmitting power."
end
function ENT:GetMaxStoredPower()
	return 5000
end
