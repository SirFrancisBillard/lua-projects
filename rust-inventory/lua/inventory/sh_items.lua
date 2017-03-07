g_ItemData = {}

function NewItem(id, base)
	base = base or "empty"
	local item = g_ItemData[base]
end

function RegisterItem(tab)
	g_ItemData[tab.ID] = tab
end
