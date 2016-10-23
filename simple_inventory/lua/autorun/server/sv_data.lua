hook.Add("DoPlayerDeath", "SimpleInventory_LoadPlayerData", function(ply, ip)
	ply:SaveInventory()
end)

hook.Add("PlayerDisconnect", "SimpleInventory_LoadPlayerData", function(ply, ip)
	ply:SaveInventory()
end)

hook.Add("PlayerSpawn", "SimpleInventory_LoadPlayerData", function(ply, ip)
	ply:LoadInventory()
end)

hook.Add("PlayerConnect", "SimpleInventory_LoadPlayerData", function(ply, ip)
	ply:LoadInventory()
end)
