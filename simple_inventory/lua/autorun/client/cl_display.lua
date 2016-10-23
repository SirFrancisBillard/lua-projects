local padding = 10
g_InvOpen = false

local function getPadding()
	return padding, padding, padding, padding
end

hook.Add("PlayerBindPress", "OpenInvInstead", function(play, bind, press)
	if string.find(bind, "menu") then
		ToggleInventoryMenu()
	end
end)

function OpenInventoryMenu()
	g_InvOpen = true

	g_SpawnMenu:Remove()

	g_InvMenu = vgui.Create("DFrame")
	g_InvMenu:SetSize(600, 300)
	g_InvMenu:Center()
	g_InvMenu:SetDraggable(true)
	g_InvMenu:ShowCloseButton(false)
	g_InvMenu:MakePopup()
	g_InvMenu:SetKeyboardInputEnabled(false)
	g_InvMenu:SetMouseInputEnabled(true)
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
	invName:SetText(LocalPlayer():Nick())
	invName:Dock(TOP)

	local invChar = vgui.Create("DModelPanel", invPanelLeft)
	invChar:SetModel(LocalPlayer():GetModel())
	invChar:Dock(FILL)
	function invChar:LayoutEntity(ent) return end
	function invChar.Entity:GetPlayerColor() return LocalPlayer():GetPlayerColor() end

	local invPanels = {}
	local invModels = {}
	local invButtons = {}

	local inv = LocalPlayer():GetInventory()
	for k, v in pairs(inv) do
		invPanels[#invPanels + 1] = vgui.Create("DPanel", invScroll)
		invPanels[#invPanels]:SetSize(0, 40)
		invPanels[#invPanels]:Dock(TOP)
		invButtons[#invButtons + 1] = vgui.Create("DButton", invPanels[#invPanels])
		invButtons[#invButtons]:SetSize(260, 40)
		invButtons[#invButtons]:Dock(FILL)
		invButtons[#invButtons]:SetText(g_ItemTable[k]["name"] .. " (" .. string.Comma(v) .. ")")
		if g_ItemTable[k]["desc"] != nil then
			invButtons[#invButtons]:SetTooltip(g_ItemTable[k]["desc"])
		end
		invButtons[#invButtons].DoClick = function()
			local itemMenu = vgui.Create("DMenu", g_InvMenu)
			itemMenu:SetPos(gui.MousePos())
			if type(g_ItemTable[k]["use"]) == "function" then
				itemMenu:AddOption(g_ItemTable[k]["func"], function()
					LocalPlayer():UseItem(k)
					RefreshInventoryMenu()
				end)
			end
			itemMenu:AddOption("Drop", function()
				LocalPlayer():DropItem(k)
				RefreshInventoryMenu()
			end)
			itemMenu:Open()
		end
		invModels[#invModels + 1] = vgui.Create("ModelImage", invButtons[#invButtons])
		invModels[#invModels]:SetSize(40, 40)
		invModels[#invModels]:Dock(LEFT)
		invModels[#invModels]:DockMargin(5, 0, 0, 0)
		invModels[#invModels]:SetModel(g_ItemTable[k]["model"])
	end
end

function CloseInventoryMenu()
	g_InvOpen = false
	if IsValid(g_InvMenu) then
		g_InvMenu:Remove()
	end
end

function RefreshInventoryMenu()
	timer.Simple(0.2, function()
		ToggleInventoryMenu()
		ToggleInventoryMenu()
	end)
end

function ToggleInventoryMenu()
	if g_InvOpen then
		CloseInventoryMenu()
	else
		OpenInventoryMenu()
	end
end

net.Receive("SimpleInventory_PlayerRefresh", RefreshInventoryMenu)
