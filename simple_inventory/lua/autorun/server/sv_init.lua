util.AddNetworkString("SimpleInventory_PlayerRefresh")
util.AddNetworkString("SimpleInventory_PlayerUseItem")
util.AddNetworkString("SimpleInventory_PlayerDropItem")
util.AddNetworkString("SimpleInventory_PlayerBuyMenu")
util.AddNetworkString("SimpleInventory_PlayerBuyItem")

net.Receive("SimpleInventory_PlayerUseItem", function(len, ply)
	local id = g_ItemTranslateFromID[net.ReadString()]
	local item = g_ItemTable[id]
	if ply:HasItem(item.id) and item.use(ply) then
		ply:TakeItem(item.id, 1)
	end
end)

net.Receive("SimpleInventory_PlayerDropItem", function(len, ply)
	local id = g_ItemTranslateFromID[net.ReadString()]
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
end)
