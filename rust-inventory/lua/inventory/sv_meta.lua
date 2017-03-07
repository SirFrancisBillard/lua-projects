local PLAYER = FindMetaTable("Player")

function PLAYER:SendInventory()
	net.Start("SendInventory")
	net.WriteTable(self.Inventory)
	net.Send(self)
end

function PLAYER:CreateInventory()
	local inv = {}

	for i = 1, 30 do
		table.insert(inv, {ID = "null", Slot = 0, Quantity = 0})
	end

	return inv
end

function PLAYER:SetItem(slot, id, amt)
	self.Inventory[slot].ID = id
	self.Inventory[slot].Slot = slot
	self.Inventory[slot].Quantity = amt

	self:SendInventory()
end
