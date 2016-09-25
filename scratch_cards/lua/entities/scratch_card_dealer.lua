AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Scratch Card Dealer"
ENT.Category = "Scratch Cards"
ENT.Spawnable = true
ENT.Model = "models/player/breen.mdl"
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
	self:SetModel(self.Model)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetNPCState(NPC_STATE_SCRIPT)
		self:SetSolid(SOLID_BBOX)
		self:SetUseType(SIMPLE_USE)
		self:SetHullType(HULL_HUMAN)
		self:SetHullSizeNormal()
		self:DropToFloor()
		self:CapabilitiesAdd(CAP_ANIMATEDFACE || CAP_TURN_HEAD)
		self:SetMaxYawSpeed(90)
	end
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
end

if SERVER then
	util.AddNetworkString("ScratchCards_OpenClientMenu")
	util.AddNetworkString("ScratchCards_BuyScratchCard")
	function ENT:StartTouch(caller)
		if IsValid(caller) and caller:IsPlayer() then
			local randy = math.random(1, 5)
			if (randy == 1) then
				caller:ChatPrint("Hello my friend.")
			elseif (randy == 2) then
				caller:ChatPrint("I can give you quality cards.")
			elseif (randy == 3) then
				caller:ChatPrint("You can win very much money!")
			elseif (randy == 4) then
				caller:ChatPrint("Straight from Mother Russia.")
			elseif (randy == 5) then
				caller:ChatPrint("Would you like to gamble?")
			end
			net.Start("ScratchCards_OpenClientMenu")
			net.Send(caller)
		end
	end
end

function ENT:Think()
	self:SetSequence("idle_all_02")
end

if CLIENT then
	net.Receive("ScratchCards_OpenClientMenu", function()
		local DermaPanel = vgui.Create("DFrame")
		DermaPanel:SetPos(100, 100)
		DermaPanel:SetSize(300, 200)
		DermaPanel:SetTitle("Scratch Cards")
		DermaPanel:SetDraggable(true)
		DermaPanel:MakePopup()
		local Button1 = vgui.Create("DButton", DermaPanel)
		Button1:SetText("Low Roller")
		Button1:SetPos(25, 50)
		Button1:SetSize(250, 30)
		Button1.DoClick = function()
			net.Start("ScratchCards_BuyScratchCard")
				net.WriteInt(1)
			net.SendToServer()
		end
		local Button2 = vgui.Create("DButton", DermaPanel)
		Button2:SetText("Medium Roller")
		Button2:SetPos(50, 50)
		Button2:SetSize(250, 30)
		Button2.DoClick = function()
			net.Start("ScratchCards_BuyScratchCard")
				net.WriteInt(2)
			net.SendToServer()
		end
		local Button3 = vgui.Create("DButton", DermaPanel)
		Button3:SetText("Medium Roller")
		Button3:SetPos(50, 50)
		Button3:SetSize(250, 30)
		Button3.DoClick = function()
			net.Start("ScratchCards_BuyScratchCard")
				net.WriteInt(3)
			net.SendToServer()
		end
	end)
	function ENT:Draw()
		self:DrawModel()
		local Ang = self:GetAngles()

		Ang:RotateAroundAxis(Ang:Forward(), 90)
		Ang:RotateAroundAxis(Ang:Right(), -90)
		
		cam.Start3D2D(self:GetPos() + (self:GetUp() * 100), Ang, 0.35)
			draw.SimpleTextOutlined("Scratch Card Dealer", "Trebuchet24", 0, 0, Color(255, 0,0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(25, 25, 25))
			draw.SimpleTextOutlined("Buy scratch cards here", "Trebuchet24", 0, 40, Color(255, 0,0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(25, 25, 25))
		cam.End3D2D()
	end
end
