g_SalesmanTable = {}

concommand.Add("salesman_add", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	local id = args[1] or "chef"
	local man = ents.Create("inv_salesman")
	man:SetPos(ply:GetEyeTrace().HitPos)
	man:SetItemID(id)
	man:Spawn()
	man:SetAngles(Angle(0, ply:GetAngles().y + 180, 0))
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
