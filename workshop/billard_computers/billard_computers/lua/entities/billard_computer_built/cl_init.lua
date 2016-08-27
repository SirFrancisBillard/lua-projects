include("shared.lua")

surface.CreateFont("ComputerFont", {
	font = "Arial",
	extended = false,
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

function ENT:Draw()
	self:DrawModel()
end

hook.Add("HUDPaint", "BillardComputerShowMoney", function()
	local tr = LocalPlayer():GetEyeTrace()
	if IsValid(tr.Entity) and (tr.Entity:GetClass() == "billard_computer_built") and (tr.Entity:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		draw.SimpleTextOutlined("$"..tostring(tr.Entity:GetStoredMoney()), "ComputerFont", ScrW() / 2, ScrH() / 2, Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255))
		draw.SimpleTextOutlined("Computer Specs", "ComputerFont", ScrW() / 2, (ScrH() / 2) + (25 * 1), Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255))
		draw.SimpleTextOutlined("Fans: "..tr.Entity:GetFans(), "ComputerFont", ScrW() / 2, (ScrH() / 2) + (25 * 2), Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255))
		draw.SimpleTextOutlined("Processors: "..tr.Entity:GetProcessors(), "ComputerFont", ScrW() / 2, (ScrH() / 2) + (25 * 3), Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255))
		draw.SimpleTextOutlined("Motherboards: "..tr.Entity:GetMotherBoards(), "ComputerFont", ScrW() / 2, (ScrH() / 2) + (25 * 4), Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255))
	end
end)
