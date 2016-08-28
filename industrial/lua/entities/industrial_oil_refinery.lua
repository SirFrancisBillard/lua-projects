AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Oil Refinery"
ENT.Spawnable = true
ENT.Model = "models/props_interiors/Radiator01a.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Refining oil turns it into fuel, a much more useful and efficient material. Fuel can be extracted from the refinery with the use key."
end
function ENT:RefineryData()
	return true, {"industrial_oil"}, 1, "industrial_fuel", 10, 20
end
