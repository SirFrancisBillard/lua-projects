
local function PlayerBleed()
	for k, v in pairs(player.GetAll()) do
		if IsValid(v) and v:IsPlayer() and v:GetNWInt("Bleed", 0) > 0 then
			v:TakeDamage(v:GetNWInt("Bleed", 0), v:GetNWEntity("BleedAttacker", v), v:GetNWEntity("BleedInflictor", v))
			v:ScreenFade(SCREENFADE.IN, Color(255, 0, 0), 0.5, 0.5)
		end
	end
end

function BuildBleedTimer()
	timer.Create("BleedTimer", 5, 0, PlayerBleed)
end

function DestroyBleedTimer()
	if timer.Exists("BleedTimer") then
		timer.Remove("BleedTimer")
	end
end

function ReloadBleedTimer()
	DestroyBleedTimer()
	BuildBleedTimer()
end
