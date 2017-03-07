local PLAYER = FindMetaTable("Player")

function PLAYER:IsInventoryFull()
	return #self.Inventory >= 30
end

function PLAYER:NextAvailableInventorySlot()
	for i = 1, 30 do
		if self.Inventory[i].ID == "empty" then
			return i
		end
	end
	return 1
end
