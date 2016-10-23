local meta = FindMetaTable("Player")

function meta:GiveItem(id, am)
	local amount = 1
	if am then
		amount = am
	end
	self:SetNWInt(NWPrefix(id), self:GetNWInt(NWPrefix(id), 0) + amount)
end

function meta:TakeItem(id, am)
	local amount = 1
	if am then
		amount = am
	end
	self:SetNWInt(NWPrefix(id), self:GetNWInt(NWPrefix(id), 0) - amount)
end

function meta:SetInventory(tab)
	for k, v in pairs(tab) do
		if self:HasItem(k) and g_ItemTable[k] != nil then
			self:SetNWInt(NWPrefix(k), 0)
			self:SetNWInt(NWPrefix(k), self:GetNWInt(NWPrefix(k), 0) + v)
		end
	end
end

function meta:SaveInventory()
	return self:SetPData("SimpleInventory", util.TableToJSON(self:GetInventory()))
end

function meta:LoadInventory()
	self:SetInventory(util.JSONToTable(self:GetPData("SimpleInventory", {})))
end
