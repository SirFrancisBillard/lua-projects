AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Weed Plant"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props/de_inferno/flower_barrel.mdl"

function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
end
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Growth")
end
function ENT:DoneGrowing()
	return (self:GetGrowth() >= 100)
end

if SERVER then
	function ENT:Think()
		if (not self:DoneGrowing()) then
			self:SetGrowth(math.Clamp(self:GetGrowth() + 1, 0, 100))
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if self:DoneGrowing() then
				self:SetGrowth(0)
				local coke = ents.Create("rp_weed")
				coke:SetPos(self:GetPos() + Vector(0, 0, 30))
				coke:Spawn()
			end
		end
	end
end
