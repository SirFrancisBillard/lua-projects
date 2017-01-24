AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Dropped Item"
ENT.Spawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "ItemID")
end

function ENT:ID()
	return g_ItemTranslateFromID[self:GetItemID()]
end

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
			self:SetItemID(self.ItemID)
		end
		if type(self:ID()) == "string" then
			self:SetModel(g_ItemTable[self:ID()]["model"])
		end
	end

	function ENT:Use(activator, caller)
		if IsValid(caller) and IsValid(self) and type(self:ID()) == "string" then
			if caller:CanGiveItem(g_ItemTable[self:ID()]["id"], 1) then
				caller:GiveItem(g_ItemTable[self:ID()]["id"], 1)
				caller:Notify("You have picked up " .. g_ItemTable[self:ID()]["name"] .. ".")
				SafeRemoveEntity(self)
			else
				caller:Notify("Your inventory is full!")
			end
		end
	end
end
