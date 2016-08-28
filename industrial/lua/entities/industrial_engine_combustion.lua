AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Combustion Engine"
ENT.Spawnable = true
ENT.Model = "models/props_interiors/Radiator01a.mdl"
function ENT:IndustrialType()
	return "gen"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Combustion engines generate power very quickly without needing water or sun, at the cost of requiring oil or fuel to function."
end
function ENT:ExtraNetworkedVars()
	self:NetworkVar("Int", 1, "GoTime")
end
function ENT:CanGeneratePower()
	return (self:GetGoTime() > 0)
end
function ENT:PowerGenerationRate()
	return 25
end
if SERVER then
	function ENT:ExtraInit()
		self:SetGoTime(0)
	end
	function ENT:Touch(toucher)
		if (toucher:GetClass() == "industrial_oil") then
			SafeRemoveEntity(toucher)
			self:SetGoTime(self:GetGoTime() + 30)
		elseif (toucher:GetClass() == "industrial_fuel") then
			SafeRemoveEntity(toucher)
			self:SetGoTime(self:GetGoTime() + 90)
		end
	end
	function ENT:ExtraThink()
		self:SetGoTime(math.Clamp(self:GetGoTime() - 1, 0, self:GetGoTime()))
	end
end
