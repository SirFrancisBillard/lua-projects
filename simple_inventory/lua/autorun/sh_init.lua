AddCSLuaFile()
AddCSLuaFile("client/cl_display.lua")
AddCSLuaFile("sh_items.lua")
AddCSLuaFile("sh_meta.lua")

function NWPrefix(txt)
	return "SimpleInventoryItem_" .. txt
end