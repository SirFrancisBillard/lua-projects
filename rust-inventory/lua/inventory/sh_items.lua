g_ItemData = {
	["empty"] = {
		ID = "empty",
		Name = "Unknown",
		Model = "models/error.mdl",
		StackSize = 100,
		OnPickup = function(ply) end,
		OnDrop = function(ply) end
	}
}

function NewItem(id, base)
	base = base or "empty"
	local item = g_ItemData[base]
	item.ID = id
	return item
end

function RegisterItem(item)
	g_ItemData[item.ID] = item
end

function GetItemData(id)
	return g_ItemData[id]
end

local ITEM = NewItem("base_weapon")
ITEM.WeaponClass = "weapon_pistol"
ITEM.OnPickup = function(ply)
	if IsValid(ply) and ply:Alive() and not ply:HasWeapon(ITEM.WeaponClass) then
		ply:Give(ITEM.WeaponClass)
	end
	return true
end
ITEM.OnDrop = function(ply)
	if IsValid(ply) and ply:Alive() and not ply:HasItem(ITEM.ID, 2) ply:HasWeapon(ITEM.WeaponClass) then
		ply:Give(ITEM.WeaponClass)
	end
	return true
end
RegisterItem(ITEM)
