local meta = FindMetaTable("Player")

function meta:GiveItem(id, am)
	local num = g_ItemTranslateFromID[id]
	if not g_ItemTable[num] or not self:CanGiveItem(num, am) then return end
	local amount = 1
	if am then
		amount = am
	end
	local inv = util.JSONToTable(self:GetNWString("SimpleInventory", g_DefInv))
	if inv[num] then
		inv[num] = inv[num] + amount
	else
		inv[num] = amount
	end
	self:SetNWString("SimpleInventory", util.TableToJSON(inv))
end

function meta:CanGiveItem(id, am)
	local num = g_ItemTranslateFromID[id]
	local amount = 1
	if am then
		amount = am
	end
	local digits = #num + #tostring(amount) + 5
	return #self:GetNWString("SimpleInventory", g_DefInv) + digits < 199
end

function meta:TakeItem(id, am)
	local num = g_ItemTranslateFromID[id]
	if not g_ItemTable[num] then return end
	local amount = 1
	if am then
		amount = am
	end
	local inv = self:GetInventory()
	if inv[num] then
		inv[num] = math.max(inv[num] - amount, 0)
	else
		inv[num] = 0
	end
	if inv[num] <= 0 then
		inv[num] = nil
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
