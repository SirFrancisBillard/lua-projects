local meta = FindMetaTable("Player")

function meta:GiveItem(id, am)
	if not g_ItemTable[id] or not self:CanGiveItem(id, am) then return end
	local amount = 1
	if am then
		amount = am
	end
	local inv = util.JSONToTable(self:GetNWString("SimpleInventory", g_DefInv))
	if inv[id] then
		inv[id] = inv[id] + amount
	else
		inv[id] = amount
	end
	self:SetNWString("SimpleInventory", util.TableToJSON(inv))
end

function meta:CanGiveItem(id, am)
	local amount = 1
	if am then
		amount = am
	end
	local digits = #id + #tostring(amount) + 5
	return #self:GetNWString("SimpleInventory", g_DefInv) + digits < 199
end

function meta:TakeItem(id, am)
	if not g_ItemTable[id] then return end
	local amount = 1
	if am then
		amount = am
	end
	local inv = self:GetInventory()
	if inv[id] then
		inv[id] = math.max(inv[id] - amount, 0)
	else
		inv[id] = 0
	end
	self:SetNWString("SimpleInventory", util.TableToJSON(inv))
end

function meta:SetInventory(tab)
	return self:SetNWString("SimpleInventory", util.TableToJSON(tab))
end

function meta:SaveInventory()
	return self:SetPData("SimpleInventory", util.TableToJSON(self:GetInventory()))
end

function meta:LoadInventory()
	self:SetInventory(util.JSONToTable(self:GetPData("SimpleInventory", {})))
end
