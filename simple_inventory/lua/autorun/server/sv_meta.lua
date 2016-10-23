local meta = FindMetaTable("Player")

function meta:GiveItem(id, am)
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

function meta:TakeItem(id, am)
	local amount = 1
	if am then
		amount = am
	end
	local inv = util.JSONToTable(self:GetNWString("SimpleInventory", g_DefInv))
	if inv[id] then
		inv[id] = math.max(inv[id] - amount, 0)
	else
		inv[id] = 0
	end
	self:SetNWString("SimpleInventory", util.TableToJSON(inv))
end

function meta:SetInventory(tab)
	return self:SetNWString(util.TableToJSON(tab))
end

function meta:SaveInventory()
	return self:SetPData("SimpleInventory", util.TableToJSON(self:GetInventory()))
end

function meta:LoadInventory()
	self:SetInventory(util.JSONToTable(self:GetPData("SimpleInventory", {})))
end
