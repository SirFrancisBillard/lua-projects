AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Salesman"
ENT.Spawnable = false

if SERVER then
	function ENT:Initialize()
		self:DrawShadow(true)
		self:SetSolid(SOLID_BBOX)
		self:PhysicsInit(SOLID_BBOX)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetUseType(SIMPLE_USE)
	end

	function ENT:Think()
		if type(self.ItemID) == "string" then
			self:SetModel(g_SalesmanTable[self.ItemID].model)
			self:SetSequence(self:LookupSequence("idle"))
		end
	end

	function ENT:Use(activator, caller)
		if IsValid(caller) and IsValid(self) and type(self.ItemID) == "string" then
			caller:GiveItem(g_ItemTable[self.ItemID].id, 1)
			SafeRemoveEntity(self)
		end
	end
elseif CLIENT then
	function ENT:Initialize()
		self.AutomaticFrameAdvance = true
	end

	function ENT:Think()
		self:FrameAdvance(FrameTime())
		self:NextThink(CurTime())
	end

	net.Receive("SimpleInventory_OpenSalesmanMenu", function(len)
		local salesMenu = vgui.Create("DFrame")
		salesMenu:SetSize(300, 300)
		salesMenu:Center()
		salesMenu:SetDraggable(true)
		salesMenu:ShowCloseButton(true)
		salesMenu:MakePopup()
		salesMenu:SetTitle("Buy Items")
	end)
end
