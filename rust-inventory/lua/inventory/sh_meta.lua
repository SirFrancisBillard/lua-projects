local PLAYER = FindMetaTable("Player")

function PLAYER:IsInventoryFull()
	return #self.Inventory >= 30
end

function PLAYER:GetItemCount(id)
	local count = 0
	for i = 1, 30 do
		if self.Inventory[i].ID == id then
			count = count + self.Inventory[i].Quantity
		end
	end
	return count
end

function PLAYER:HasItem(id, amt)
	amt = amt or 1
	self:GetItemCount() >= amt
end

function PLAYER:CanReceiveItem(id, amt)
	local max = GetItemData(id).StackSize
	-- TODO
end

function PLAYER:IsItemOnHotbar(id, amt)
	amt = amt or 1
	local found = 0
	for i = 25, 30 do
		if self.Inventory[i].ID == id then
			found = found + self.Inventory[i].Quantity
			if found >= amt then
				return true
			end
		end
	end
	return false
end

function PLAYER:HasAvailableInventorySlot()
	for i = 1, 30 do
		if not self.Inventory[i].ID == "empty" then
			return true
		end
	end
	return false
end

function PLAYER:NextAvailableInventorySlot()
	for i = 1, 30 do
		if self.Inventory[i].ID == "empty" then
			return i
		end
	end
	return 1
end
