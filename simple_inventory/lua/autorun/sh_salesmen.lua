g_SalesmanTable = {}

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
	soldItems = {"melon"}
})

RegisterSalesman({
	id = "hardware",
	name = "Hardware Store",
	model = "models/player/monk.mdl",
	soldItems = {"wood", "bucket", "shovel"}
})
