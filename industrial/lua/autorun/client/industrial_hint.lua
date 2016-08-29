AddCSLuaFile()

surface.CreateFont("IndustrialFont", {
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
hook.Add("HUDPaint", "IndustrialMod_DrawHints", function()
	local tr = LocalPlayer():GetEyeTrace()
	local clrWhite = Color(0, 0, 0, 255)
	local clrBlack = Color(255, 255, 255, 255)
	local halfScrH = (ScrH() / 2) + 25
	local halfScrW = ScrW() / 2
	local trent = tr.Entity
	if IsValid(trent) and (trent.GetStoredPower != nil) and (trent:IndustrialType() != "base") and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		draw.SimpleTextOutlined("Power: "..trent:GetStoredPower().."/"..trent:GetMaxStoredPower(), "IndustrialFont", halfScrW, halfScrH, clrWhite, 1, 1, 1, clrBlack)
	end
end)
