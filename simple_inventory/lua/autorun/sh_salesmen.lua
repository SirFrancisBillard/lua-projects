g_SalesmanTable = {}

concommand.Add("salesman_add", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	local id = args[1] or "chef"
	local man = ents.Create("inv_salesman")
	man:SetPos(ply:GetEyeTrace().HitPos)
	man:SetItemID(id)
	man:Spawn()
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
	id = "hardware",
	name = "Hardware Store",
	model = "models/player/monk.mdl",
	soldItems = {["kettle"] = 180}
})