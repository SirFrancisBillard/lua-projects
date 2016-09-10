AddCSLuaFile()

hook.Add("HUDPaint", "CrimePlus_DrawHints", function()
	local tr = LocalPlayer():GetEyeTrace()
	local clrWhite = Color(0, 0, 0, 255)
	local clrBlack = Color(255, 255, 255, 255)
	local halfScrH = ScrH() / 2
	local halfScrW = ScrW() / 2
	local trent = tr.Entity
	if IsValid(trent) and (trent.GetCookingProgress != nil) and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		draw.SimpleTextOutlined("Cooking Progress: "..trent:GetCookingProgress().."/100", "Default", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
	end
	if IsValid(trent) and (trent.GetMixingProgress != nil) and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		draw.SimpleTextOutlined("Mixing Progress: "..trent:GetMixingProgress().."/100", "Default", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
	end
	if IsValid(trent) and (trent.GetGrowth != nil) and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		draw.SimpleTextOutlined("Growth: "..trent:GetGrowth().."/100", "Default", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
	end
	if IsValid(trent) and (trent.GetFuel != nil) and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		draw.SimpleTextOutlined("Fuel: "..trent:GetFuel().."/200", "Default", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
	end
end)
