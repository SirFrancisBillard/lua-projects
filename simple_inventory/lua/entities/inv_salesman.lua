AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Salesman"
ENT.Spawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "ItemID")
end

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
			self:SetModel(g_SalesmanTable[self:GetItemID()]["model"])
			self:SetSequence(self:LookupSequence("idle"))
		end
	end

	function ENT:Use(activator, caller)
		if IsValid(caller) and IsValid(self) and type(self:GetItemID()) == "string" then
			net.Start("SimpleInventory_PlayerBuyMenu")
			net.Send(caller)
		end
	end

	net.Receive("SimpleInventory_PlayerBuyItem", function(len, ply)
		local man = net.ReadEntity()
		local id = net.ReadString()
		if man:GetClass() != ENT.ClassName then return end
		if man:GetPos():DistToSqr(ply:GetPos()) > 262144 then return end
		if g_ItemTable[id] == nil then return end
		if not ply:canAfford(g_SalesmanTable[ENT:GetItemID()]["soldItems"][id]) then return end
		ply:addMoney(-g_SalesmanTable[ENT:GetItemID()]["soldItems"][id])
		ply:GiveItem(id)
	end)
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
		salesMenu:SetTitle(g_SalesmanTable[ENT:GetItemID()]["name"])

		local invScroll = vgui.Create("DScrollPanel", salesMenu)
		invScroll:SetSize(69, 69)
		invScroll:Dock(FILL)

		local invPanels = {}
		local invModels = {}
		local invButtons = {}

		for k, v in pairs(g_SalesmanTable[ENT:GetItemID()]["soldItems"]) do
			invPanels[#invPanels + 1] = vgui.Create("DPanel", invScroll)
			invPanels[#invPanels]:SetSize(0, 40)
			invPanels[#invPanels]:Dock(TOP)
			invModels[#invModels + 1] = vgui.Create("ModelImage", invPanels[#invPanels])
			invModels[#invModels]:SetSize(40, 40)
			invModels[#invModels]:Dock(LEFT)
			invModels[#invModels]:SetModel(g_ItemTable[k]["model"])
			invButtons[#invButtons + 1] = vgui.Create("DButton", invPanels[#invPanels])
			invButtons[#invButtons]:SetSize(240, 40)
			invButtons[#invButtons]:Dock(RIGHT)
			invButtons[#invButtons]:SetText(g_ItemTable[k]["name"] .. " ($" .. string.Comma(v) .. ")")
			if g_ItemTable[k]["desc"] != nil then
				invButtons[#invButtons]:SetTooltip(g_ItemTable[k]["desc"])
			end
			invButtons[#invButtons].DoClick = function()
				local itemMenu = vgui.Create("DMenu", salesMenu)
				itemMenu:SetPos(gui.MousePos())
				itemMenu:AddOption("Buy", function()
					net.Start("SimpleInventory_PlayerBuyItem")
						net.WriteEntity(ENT)
						net.WriteString(k)
					net.SendToServer()
				end)
				itemMenu:Open()
			end
		end
	end)
end
