AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Dropped Item"
ENT.Spawnable = false

function ENT:Initialize()
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
	if not self.InitAgain then
		timer.Simple(0.2, function()
			self.InitAgain = true
			self:Initialize()
		end)
	end
end

if SERVER then
	function ENT:Think()
		if type(self.ItemID) == "string" then
			self:SetModel(g_ItemTable[self.ItemID].model)
		end
	end

	function ENT:Use(activator, caller)
		if IsValid(caller) and IsValid(self) and type(self.ItemID) == "string" then
			caller:GiveItem(g_ItemTable[self.ItemID].id, 1)
			SafeRemoveEntity(self)
		end
	end
end
