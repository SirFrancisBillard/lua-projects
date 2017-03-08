local PLAYER = FindMetaTable("Player")

function PLAYER:GetFilledInventorySlots()
	local filled = 0
	for i = 1, 30 do
		if not self.Inventory[i].ID == "empty" then
			filled = filled + 1
		end
	end
	return filled
end

function PLAYER:IsInventoryFull()
	return self:GetFilledInventorySlots() >= 30
end

function PLAYER:HasAvailableInventorySlots(amt)
	amt = amt or 1
	return self:GetFilledInventorySlots() <= (30 - amt)
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
	return self:GetItemCount() >= amt
end

function PLAYER:CanReceiveItem(id, amt)
	local max = GetItemData(id).StackSize
	local slots_needed
	if amt > max then
		slots_needed = math.ceil(amt % max)
	else
		slots_needed = 1
	end
	if self:HasAvailableInventorySlots(slots_needed) then
		return true, amt
	end
	local should_put = math.min(amt, max - foundamt)
	-- if inv is full, make sure we have the item and can stack
	local space_in_stacks = 0
	for i = 1, 30 do
		if self.Inventory[i].ID == id then
			space_in_stacks = space_in_stacks + (max - self.Inventory[i].Quantity)
		end
	end
	if amt > space_in_stacks then
		return true, space_in_stacks
	end
	return false, 0
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

function PLAYER:NextAvailableInventorySlot()
	for i = 1, 30 do
		if self.Inventory[i].ID == "empty" then
			return i
		end
	end
	return 1
end
