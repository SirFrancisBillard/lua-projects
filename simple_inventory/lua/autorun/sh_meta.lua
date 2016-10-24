local meta = FindMetaTable("Player")

function meta:HasItem(id, am)
	local tab = util.JSONToTable(self:GetNWString("SimpleInventory", g_DefInv))
	local amount = 1
	if am then
		amount = am
	end
	return type(tab[id]) == "number" and tab[id] >= amount
end

function meta:GetInventory()
	return util.JSONToTable(self:GetNWString("SimpleInventory", g_DefInv))
end

function meta:RefreshInventory()
	if SERVER then
		net.Start("SimpleInventory_PlayerRefresh")
		net.Send(self)
	elseif CLIENT then
		RefreshInventoryMenu()
	end
end

function meta:UseItem(id)
	local item = g_ItemTable[id]
	if SERVER then
		if ply:HasItem(id) and item.use(ply) then
			ply:TakeItem(id, 1)
			return true
		else
			return false
		end
	elseif CLIENT then
		net.Start("SimpleInventory_PlayerUseItem")
			net.WriteString(id)
		net.SendToServer()
	end
end

function meta:DropItem(id)
	if SERVER then
		local item = g_ItemTable[id]
		if ply:HasItem(item.id) then
			ply:TakeItem(item.id, 1)

			local ent = ents.Create("inv_dropped_item")
			ent.ItemID = id
			ent:Spawn()
			ent:Initialize()
			ent:Activate()

			local pos, mins = ent:GetPos(), ent:WorldSpaceAABB()
			local offset = pos.z - mins.z

			local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 85
			trace.filter = ply

			local tr = util.TraceLine(trace)
			ent:SetPos(tr.HitPos + Vector(0, 0, offset))

			local phys = ent:GetPhysicsObject()
			timer.Simple(0, function() if phys:IsValid() then phys:Wake() end end)
		end
	elseif CLIENT then
		net.Start("SimpleInventory_PlayerDropItem")
			net.WriteString(id)
		net.SendToServer()
	end
end

function meta:Notify(txt)
	if SERVER then
		self:ChatPrint(txt)
	end
end
