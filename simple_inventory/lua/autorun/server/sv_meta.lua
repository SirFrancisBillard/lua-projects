local meta = FindMetaTable("Player")

function meta:GiveItem(id, am)
	local amount = 1
	if am then
		amount = am
	end
	self:GiveAmmo(amount, id, false)
end

function meta:TakeItem(id, am)
	local amount = 1
	if am then
		amount = am
	end
	self:RemoveAmmo(amount, id)
end

function meta:SetInventory(tab)
	for k, v in pairs(tab) do
		if self:HasItem(k) and g_ItemTable[k] != nil then
			self:RemoveAmmo(self:GetAmmoCount(k), k)
			self:GiveAmmo(v, k)
		end
	end
end

function meta:SaveInventory()
	return self:SetPData("SimpleInventory", util.TableToJSON(self:GetInventory()))
end

function meta:LoadInventory()
	self:SetInventory(util.JSONToTable(self:GetPData("SimpleInventory", {})))
end
