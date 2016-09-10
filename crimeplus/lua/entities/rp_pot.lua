AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Pot"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_c17/metalPot001a.mdl"

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
	self:NetworkVar("Int", 0, "CookingProgress")
	self:NetworkVar("Bool", 0, "IsCooking")
	self:NetworkVar("Bool", 1, "HasSodium")
	self:NetworkVar("Bool", 2, "HasChloride")
end
function ENT:CanCook()
	return (self:GetHasSodium() and self:GetHasChloride() and self:GetIsCooking())
end
function ENT:DoneCooking()
	return (self:GetCookingProgress() >= 100)
end

if SERVER then
	function ENT:Touch(ent)
		if IsValid(ent) and (ent:GetClass() == "rp_stove") then
			if (ent:GetHasCanister() and (ent:GetCanister():GetFuel() > 0)) then
				self:SetIsCooking(true)
			else
				self:SetIsCooking(false)
			end
		end
	end
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if (ent:GetClass() == "rp_sodium") and (not self:GetHasSodium()) then
				SafeRemoveEntity(ent)
				self:SetHasSodium(true)
			end
			if (ent:GetClass() == "rp_chloride") and (not self:GetHasChloride()) then
				SafeRemoveEntity(ent)
				self:SetHasChloride(true)
			end
		end
	end
	function ENT:Think()
		if self:CanCook() and (not self:DoneCooking()) then
			self:SetCookingProgress(math.Clamp(self:GetCookingProgress() + 1, 0, 100))
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if self:DoneCooking() then
				self:SetCookingProgress(0)
				self:SetHasSodium(false)
				self:SetHasChloride(false)
				local meth = ents.Create("rp_meth")
				meth:SetPos(self:GetPos() + Vector(0, 0, 30))
				meth:Spawn()
			end
		end
	end
end
