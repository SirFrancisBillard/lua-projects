AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Dropped Item"
ENT.Spawnable = false

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
