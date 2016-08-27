AddCSLuaFile()
local SHARED = true

if SHARED then
	ENT.Type = "anim"
	ENT.Base = "base_gmodentity"
	ENT.PrintName = "Industrial Base Entity"
	ENT.Category = "Industrial Mod"
	ENT.Spawnable = false
	ENT.Model = "models/Items/combine_rifle_ammo01.mdl"
	ENT.InteractionRadius = 80
	function ENT:IndustrialType()
		return "base"
		// valid types and their uses
		// base - does nothing
		// gen - generates power
		// bat - stores power
		// mach - uses power
	end
	function ENT:CanTransmitPower()
		return self.CanTransmitPower or true
	end
	function ENT:CanReceivePower()
		return self.CanReceivePower or true
	end
	function ENT:PowerTransmitRate()
		return self.PowerTransmitRate or 20
	end
	function ENT:SetupDataTables()
		self:NetworkVar("Int", 0, "StoredPower")
	end
	function ENT:GetMaxStoredPower()
		return self.MaxStoredPower or 200
	end
	function ENT:GetInteractionRadius()
		return self.InteractionRadius or 80
	end
end

if SERVER then
	function ENT:Initialize()
		self:SetModel(ENT.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
		self:SetUseType(SIMPLE_USE or 3)
	end
	function ENT:OnEntityUsed(ply) end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			self:OnEntityUsed(ply)
		end
	end
	function ENT:Cooldown()
		return self.Cooldown or 1
	end
	function ENT:Think()
		if (not self:IndustrialType() == "base") and (not self:IndustrialType() == "mach") then
			for k, v in ents.FindInSphere(self:GetPos(), self:GetInteractionRadius()) do
				if IsValid(v) then
					local tr = util.TraceLine({start = self:GetPos(), endpos = v:GetPos(), filter = {self, v}})
					if (not tr.HitWorld) and (type(tr.Entity:IndustrialType) == "function") then
						if (self:IndustrialType() == "bat") and (v:IndustrialType() == "mach") then
							if self:CanTransmitPower() and v:CanReceivePower() then
								local amt = math.Clamp(self:PowerTransmitRate(), 0, math.Min(self:GetStoredPower(), v:GetMaxStoredPower() - v:GetStoredPower()))
								self:SetStoredPower(self:GetStoredPower() - amt)
								v:SetStoredPower(self:GetStoredPower() + amt)
							end
						end
						if self:IndustrialType() == "gen" and (not v:IndustrialType() == "base") then
							if self:CanTransmitPower() and v:CanReceivePower() then
								local amt = math.Clamp(self:PowerTransmitRate(), 0, math.Min(self:GetStoredPower(), v:GetMaxStoredPower() - v:GetStoredPower()))
								self:SetStoredPower(self:GetStoredPower() - amt)
								v:SetStoredPower(self:GetStoredPower() + amt)
							end
						end
					end
				end
			end
		end
		self:NextThink(CurTime() + self:Cooldown())
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
