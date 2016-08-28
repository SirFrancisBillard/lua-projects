AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Solar Panel"
ENT.Spawnable = true
ENT.Model = "models/props_phx/construct/metal_plate1.mdl"
function ENT:IndustrialType()
	return "gen"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Solar panels are an easy way to make power at a mediocre rate, but they must have no roof over them to do so"
end
function ENT:CanGeneratePower()
	return self:CanSeeSky()
end
