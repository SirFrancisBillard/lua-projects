local ply = LocalPlayer()
local padding = 10

local function getPadding()
	return padding, padding, padding, padding
end

hook.Add("OnSpawnMenuOpen", "OpenInvInstead", function()
	OpenInventoryMenu()
end)

hook.Add("OnSpawnMenuClose", "CloseInvInstead", function()
	CloseInventoryMenu()
end)

function UseItem(id)
	net.Start("SimpleInventory_PlayerUseItem")
		net.WriteString(id)
	net.SendToServer()
end

function DropItem(id)
	net.Start("SimpleInventory_PlayerDropItem")
		net.WriteString(id)
	net.SendToServer()
end

function OpenInventoryMenu()
	g_InvMenu = vgui.Create("DFrame")
	g_InvMenu:SetSize(600, 300)
	g_InvMenu:Center()
	g_InvMenu:SetDraggable(false)
	g_InvMenu:ShowCloseButton(false)
	g_InvMenu:SetMouseInputEnabled(true)
	g_InvMenu:MakePopup()
	g_InvMenu:SetTitle("Inventory")

	local invPanelLeft = vgui.Create("DPanel", g_InvMenu)
	invPanelLeft:SetSize(300, 0)
	invPanelLeft:Dock(LEFT)
	invPanelLeft:DockPadding(getPadding())

	local invPanelRight = vgui.Create("DPanel", g_InvMenu)
	invPanelRight:SetSize(300, 0)
	invPanelRight:Dock(RIGHT)
	invPanelRight:DockPadding(getPadding())

	local invScroll = vgui.Create("DScrollPanel", invPanelRight)
	invScroll:SetSize(300, 0)
	invScroll:Dock(FILL)

	local invName = vgui.Create("DLabel", invPanelLeft)
	invName:SetTextColor(color_black)
	invName:SetText(ply:Nick())
	invName:Dock(TOP)

	local invChar = vgui.Create("DModelPanel", invPanelLeft)
	invChar:SetModel(ply:GetModel())
	invChar:Dock(FILL)
	function invChar:LayoutEntity(ent) return end
	function invChar.Entity:GetPlayerColor() return Vector(ply:GetPlayerColor().r / 255, ply:GetPlayerColor().g / 255, ply:GetPlayerColor().b / 255) end

	local invPanels = {}
	local invModels = {}
	local invButtons = {}

	local inv = ply:GetInventory()
	for k, v in pairs(inv) do
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
		invButtons[#invButtons]:SetText(g_ItemTable[k]["name"] .. " (" .. v .. ")")
		if g_ItemTable[k]["desc"] != nil then
			invButtons[#invButtons]:SetTooltip(g_ItemTable[k]["desc"])
		end
		invButtons[#invButtons].DoClick = function()
			local itemMenu = vgui.Create("DMenu", g_InvMenu)
			itemMenu:SetPos(gui.MousePos())
			if type(g_ItemTable[k]["use"]) == "function" then
				itemMenu:AddOption(g_ItemTable[k]["func"], function()
					UseItem(k)
					RefreshInventoryMenu()
				end)
			end
			itemMenu:AddOption("Drop", function()
				DropItem(k)
				RefreshInventoryMenu()
			end)
			itemMenu:Open()
		end
	end
end

function CloseInventoryMenu()
	if IsValid(g_InvMenu) then
		g_InvMenu:Remove()
	end
end

function RefreshInventoryMenu()
	CloseInventoryMenu()
	OpenInventoryMenu()
end
