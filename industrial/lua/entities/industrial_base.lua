AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Industrial Base Entity"
ENT.Category = "Industrial Mod"
ENT.Spawnable = false
ENT.Model = "models/Items/combine_rifle_ammo01.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "No help text found. Sorry!"
end
function ENT:CanTransmitPower()
	return true
end
function ENT:CanGeneratePower()
	return false
end
function ENT:CanReceivePower()
	return true
end
function ENT:PowerTransmitRate()
	return 20
end
function ENT:PowerGenerationRate()
	return 10
end
function ENT:ExtraNetworkedVars() end
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "StoredPower")
	self:ExtraNetworkedVars()
end
function ENT:GetMaxStoredPower()
	return 200
end
function ENT:GetInteractionRadius()
	return 80
end
function ENT:CanSeeSky()
	local tr = util.TraceLine({start = self:GetPos(), endpos = self:GetPos() + Vector(0, 0, 2048), filter = self})
	return tr.HitSky
end

if SERVER then
	function ENT:ExtraInit() end
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
		self:SetUseType(SIMPLE_USE or 3)
		self:SetStoredPower(0)
		self:ExtraInit()
	end
	function ENT:OnEntityUsed(ply) end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			self:OnEntityUsed(ply)
		end
	end
	function ENT:ExtraThink() end
	function ENT:Think()
		if (self:IndustrialType() != "base") and (self:IndustrialType() != "mach") then
			// send power
			for k, v in pairs(ents.FindInSphere(self:GetPos(), self:GetInteractionRadius())) do
				if IsValid(v) and (v.IndustrialType != nil) then
					if (self:IndustrialType() == "bat") and (v:IndustrialType() == "mach") then
						if self:CanTransmitPower() and v:CanReceivePower() then
							local amt = math.Clamp(self:PowerTransmitRate(), 0, math.Min(self:GetStoredPower(), v:GetMaxStoredPower() - v:GetStoredPower()))
							self:SetStoredPower(self:GetStoredPower() - amt)
							v:SetStoredPower(v:GetStoredPower() + amt)
						end
					end
					if (self:IndustrialType() == "gen") or ((v:IndustrialType() == "bat") or (v:IndustrialType() == "mach")) then
						if self:CanTransmitPower() and v:CanReceivePower() then
							local amt = math.Clamp(self:PowerTransmitRate(), 0, math.Min(self:GetStoredPower(), v:GetMaxStoredPower() - v:GetStoredPower()))
							self:SetStoredPower(self:GetStoredPower() - amt)
							v:SetStoredPower(v:GetStoredPower() + amt)
						end
					end
				end
			end
			// generate power
			if self:CanGeneratePower() then
				self:SetStoredPower(math.Clamp(self:GetStoredPower() + self:PowerGenerationRate(), 0, self:GetMaxStoredPower()))
			end
		end
		self:ExtraThink()
		self:NextThink(CurTime() + 1)
		return true
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
