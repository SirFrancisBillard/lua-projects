AddCSLuaFile()

g_ItemTable = {}
g_DefaultInventory = {}

local PlyMeta = FindMetaTable("Player")

function CreateItem(tab)
	if not tab.id then return end
	local item = {
		id = tab.id,
		name = tab.name,
		use = tab.use
	}
	g_ItemTable[item.id] = item
end

function PlyMeta:GetInventory()
	return self.inventory or g_DefaultInventory
end

function PlyMeta:HasItem(item, amt)
	if g_ItemTable[item] ~= nil and amt > 0 then
		local inv = self:GetInventory()
		return inv[item] ~= nil and inv[item] >= amt
	end
end

function PlyMeta:UseItem(item)
	if SERVER then
		if g_ItemTable[item] ~= nil and self:HasItem(item, 1) then
			g_ItemTable[item].use(ply)
			self:TakeItem(item, 1)
		end
	else -- CLIENT
		net.Start("UseInventoryItem")
			net.WriteString(item)
		net.SendToServer()
	end
end

if SERVER then
	util.AddNetworkString("SendInventoryToClient")
	util.AddNetworkString("UseInventoryItem")

	net.Receive("UseInventoryItem", function(len, ply)
		local item = net.ReadString()
		if g_ItemTable[item] ~= nil then
			ply:UseItem(item)
		end
	end)

	function PlyMeta:SendInventory()
		self.inventory = self.inventory or g_DefaultInventory
		net.Start("SendInventoryToClient")
			net.WriteTable(self.inventory)
		net.Send(self) -- wat
	end

	function PlyMeta:GiveItem(item, amt)
		if g_ItemTable[item] ~= nil and amt > 0 then
			if self.inventory[item] == nil then
				self.inventory[item] = amt
			else
				self.inventory[item] = self.inventory[item] + amt
			end
			self:SendInventory()
		end
	end

	function PlyMeta:TakeItem(item, amt)
		if g_ItemTable[item] ~= nil and amt > 0 and self:HasItem(item, amt) then
			self.inventory[item] = self.inventory[item] - amt
			self:SendInventory()
		end
	end
else -- CLIENT
	net.Receive("SendInventoryToClient", function(len)
		LocalPlayer().inventory = net.ReadTable() or g_DefaultInventory
		RefreshInventoryMenu()
	end)
end
