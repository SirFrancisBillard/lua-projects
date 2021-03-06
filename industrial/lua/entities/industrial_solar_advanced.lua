AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Advanced Solar Panel"
ENT.Spawnable = true
ENT.Model = "models/props_phx/construct/metal_plate2x2.mdl"
function ENT:IndustrialType()
	return "gen"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Advanced solar panels generate much more power than their normal counterparts."
end
function ENT:PowerTransmitRate()
	return 240
end
function ENT:PowerGenerationRate()
	return 120
end
function ENT:GetMaxStoredPower()
	return 1200
end
function ENT:CanGeneratePower()
	return self:CanSeeSky()
end
