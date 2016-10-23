g_ItemTable = {}
g_RecipeTable = {}

function RegisterItem(tab)
	local item = tab
	if not item.id or not item.name then return end
	game.AddAmmoType({name = item.id, dmgtype = DMG_BULLET})
	if CLIENT then
		language.Add(item.id .. "_ammo", item.name)
	end
	item.func = item.func or "Use"
	item.use = item.use or "nope"
	if type(item.recipe) == "table" then
		item.oldUse = item.use
		item.use = function(ply)
			local good = true
			for k, v in pairs(item.recipe.needs) do
				if not ply:HasItem(k, v) then
					good = false
				end
			end
			if good then
				for k, v in pairs(item.recipe.needs) do
					ply:TakeItem(k, v)
				end
				ply:GiveItem(item.recipe.product)
			end
			return good
		end
	end
	item.model = item.model or "models/error.mdl"
	item.price = item.price or 10
	g_ItemTable[item.id] = item
end

RegisterItem{
	id = "melon",
	name = "Watermelon",
	desc = "A lovely fruit.",
	func = "Eat",
	model = "models/props_junk/watermelon01.mdl",
	use = function(ply)
		ply:SetHealth(math.min(ply:Health() + 1, ply:GetMaxHealth()))
		return true
	end
}
