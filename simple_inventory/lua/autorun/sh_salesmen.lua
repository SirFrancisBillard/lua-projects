g_SalesmanTable = {}
g_MapSalesmen = {}

concommand.Add("salesman_add", function(ply, cmd, args)
	if not IsValid(ply) or not ply:IsAdmin() then return end
	local id = args[1] or "chef"
	local man = ents.Create("inv_salesman")
	man:SetPos(ply:GetEyeTrace().HitPos)
	man:SetAngles(Angle(0, ply:GetAngles().y + 180, 0))
	man:SetItemID(id)
	man:Spawn()
	if not g_MapSalesmen[game.GetMap()] then
		g_MapSalesmen[game.GetMap()] = {}
	end
	g_MapSalesmen[game.GetMap()][man:GetPos()] = {kind = id, ang = man:GetAngles()}
end)

concommand.Add("salesman_remove", function(ply, cmd, args)
	if not IsValid(ply) or not ply:IsAdmin() then return end
	local trent = ply:GetEyeTrace().Entity
	if IsValid(trent) and trent.IsSalesman then
		SafeRemoveEntity(trent)
		if g_MapSalesmen[game.GetMap()] and g_MapSalesmen[game.GetMap()][trent:GetPos()] then
			g_MapSalesmen[game.GetMap()][trent:GetPos()] = nil
		end
	end
end)

concommand.Add("salesman_clear", function(ply, cmd, args)
	for k, v in pairs(ents.FindByClass("inv_salesman")) do
		if IsValid(v) and v.IsSalesman then
			SafeRemoveEntity(v)
			if g_MapSalesmen[game.GetMap()] and g_MapSalesmen[game.GetMap()][v:GetPos()] then
				g_MapSalesmen[game.GetMap()][v:GetPos()] = nil
			end
		end
	end
end)

concommand.Add("salesman_load", function(ply, cmd, args)
	for k, v in pairs(ents.FindByClass("inv_salesman")) do
		if IsValid(v) and v.IsSalesman then
			SafeRemoveEntity(v)
		end
	end
	if not g_MapSalesmen[game.GetMap()] then
		g_MapSalesmen[game.GetMap()] = {}
		return
	end
	for k, v in pairs(g_MapSalesmen[game.GetMap()]) do
		local man = ents.Create("inv_salesman")
		man:SetPos(k)
		man:SetAngles(v.ang)
		man:SetItemID(v.kind)
		man:Spawn()
	end
end)

function RegisterSalesman(tab)
	local man = tab
	if not man.id or not man.name then return end
	man.model = man.model or "models/player/odessa.mdl"
	man.soldItems = man.soldItems or {}
	g_SalesmanTable[man.id] = man
end

RegisterSalesman({
	id = "chef",
	name = "Chef",
	model = "models/player/magnusson.mdl",
	soldItems = {["melon"] = 10, ["coffee_grounds"] = 60}
})

RegisterSalesman({
	id = "doctor",
	name = "Doctor",
	model = "models/player/kleiner.mdl",
	soldItems = {["medkit"] = 50, ["health_vial"] = 25}
})

RegisterSalesman({
	id = "hardware",
	name = "Hardware Clerk",
	model = "models/player/monk.mdl",
	soldItems = {["kettle"] = 180}
})

RegisterSalesman({
	id = "drug",
	name = "Drug Dealer",
	model = "models/player/soldier_stripped.mdl",
	soldItems = {["cocaine"] = 540, ["weed"] = 420, ["heroin"] = 260}
})
