local meta = FindMetaTable("Player")

function meta:HasItem(id, am)
	if am == nil then
		return self:GetAmmoCount(id) > 0
	else
		return self:GetAmmoCount(id) >= am
	end
end

function meta:GetInventory()
	local inv = {}
	for k, v in pairs(game.BuildAmmoTypes()) do
		if self:HasItem(v.name) and g_ItemTable[v.name] != nil then
			inv[v.name] = self:GetAmmoCount(v.name)
		end
	end
	return inv
end

function meta:UseItem(id)
	self:ConCommand("_____use_item_" .. item.id)
end
