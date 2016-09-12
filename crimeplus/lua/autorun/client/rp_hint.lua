AddCSLuaFile()

hook.Add("HUDPaint", "CrimePlus_DrawHints", function()
	local tr = LocalPlayer():GetEyeTrace()
	local clrWhite = Color(255, 255, 255, 255)
	local clrBlack = Color(0, 0, 0, 255)
	local halfScrH = ScrH() / 2
	local halfScrW = ScrW() / 2
	local trent = tr.Entity
	if IsValid(trent) and (trent.GetCookingProgress != nil) and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		local texGradient = surface.GetTextureID("gui/gradient_up")
   		surface.SetTexture(texGradient)
    	surface.SetDrawColor(30,30,30,200)
    	surface.DrawRect((ScrW()/2.25), (ScrH()/2), (ScrW()/9), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawTexturedRect((ScrW()/2.25), (ScrH()/2), (ScrW()/9), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawOutlinedRect((ScrW()/2.25), (ScrH()/2), (ScrW()/9), (ScrH()/15))
			draw.SimpleText("Cooking Progress: "..trent:GetCookingProgress().."/100", "DarkRPHUD3", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
			draw.SimpleText("Meth Pot", "DarkRPHUD4", halfScrW, halfScrH + 10, clrWhite, 1, 1, 1, clrBlack)
	end

	if IsValid(trent) and (trent.GetMixingProgress != nil) and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		local texGradient = surface.GetTextureID("gui/gradient_up")
   		surface.SetTexture(texGradient)
    	surface.SetDrawColor(30,30,30,200)
    	surface.DrawRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawTexturedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawOutlinedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
			draw.SimpleTextOutlined("Mixing Progress: "..trent:GetMixingProgress().."/100", "DarkRPHUD3", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
			draw.SimpleText("Cocaine Barrel", "DarkRPHUD4", halfScrW, halfScrH + 10, clrWhite, 1, 1, 1, clrBlack)
	end

	if IsValid(trent) and (trent:GetClass() == "rp_weed_plant") and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		local texGradient = surface.GetTextureID("gui/gradient_up")
   		surface.SetTexture(texGradient)
    	surface.SetDrawColor(30,30,30,200)
    	surface.DrawRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawTexturedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawOutlinedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	draw.SimpleText("Cannabis Plant", "DarkRPHUD4", halfScrW, halfScrH + 10, clrWhite, 1, 1, 1, clrBlack)
			draw.SimpleTextOutlined("Growth: "..trent:GetGrowth().."/100", "DarkRPHUD3", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
	end

		if IsValid(trent) and (trent:GetClass() == "rp_coca") and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		local texGradient = surface.GetTextureID("gui/gradient_up")
   		surface.SetTexture(texGradient)
    	surface.SetDrawColor(30,30,30,200)
    	surface.DrawRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawTexturedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawOutlinedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	draw.SimpleText("Coca Plant", "DarkRPHUD4", halfScrW, halfScrH + 10, clrWhite, 1, 1, 1, clrBlack)
			draw.SimpleTextOutlined("Growth: "..trent:GetGrowth().."/100", "DarkRPHUD3", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
	end

	if IsValid(trent) and (trent.GetFuel != nil) and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		local texGradient = surface.GetTextureID("gui/gradient_up")
   		surface.SetTexture(texGradient)
    	surface.SetDrawColor(30,30,30,200)
    	surface.DrawRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawTexturedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawOutlinedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    		draw.SimpleTextOutlined("Fuel: "..trent:GetFuel().."/200", "DarkRPHUD3", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
	end
	if IsValid(trent) and (trent.GetAlcohol != nil) and (trent:GetPos():Distance(LocalPlayer():EyePos()) < 256) then
		if (trent.GetFermentingProgress != nil) then
					local texGradient = surface.GetTextureID("gui/gradient_up")
   		surface.SetTexture(texGradient)
    	surface.SetDrawColor(30,30,30,200)
    	surface.DrawRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawTexturedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawOutlinedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
			draw.SimpleTextOutlined(trent:GetAlcohol().." Progress: "..trent:GetFermentingProgress().."/100", "DarkRPHUD3", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
		else
		local texGradient = surface.GetTextureID("gui/gradient_up")
   		surface.SetTexture(texGradient)
    	surface.SetDrawColor(30,30,30,200)
    	surface.DrawRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawTexturedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
    	surface.SetDrawColor(0, 76, 102, 200)
    	surface.DrawOutlinedRect((ScrW()/2.22), (ScrH()/2), (ScrW()/10), (ScrH()/15))
			draw.SimpleTextOutlined(trent:GetAlcohol(), "DarkRPHUD3", halfScrW, halfScrH + 25, clrWhite, 1, 1, 1, clrBlack)
		end
	end
end)
