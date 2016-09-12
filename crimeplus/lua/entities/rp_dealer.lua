AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Drug Addict"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/player/group03/male_08.mdl"
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
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			local randy = math.random(1, 5)
			if (randy == 1) then
				caller:ChatPrint("What the fuck do you want?")
			elseif (randy == 2) then
				caller:ChatPrint("Get lost, buddy.")
			elseif (randy == 3) then
				caller:ChatPrint("We don't appreciate your kind.")
			elseif (randy == 4) then
				caller:ChatPrint("What do you need?")
			elseif (randy == 5) then
				caller:ChatPrint("Make it quick, I got five warrants.")
			end
		end
	end
end

function ENT:Think()
	self:SetSequence("idle_all_01")
end

hook.Add("PostDrawOpaqueRenderables", "dealerdrughead", function()
	for _, ent in pairs (ents.FindByClass("rp_dealer")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
			local Ang = ent:GetAngles()

			Ang:RotateAroundAxis( Ang:Forward(), 90)
			Ang:RotateAroundAxis( Ang:Right(), -90)
		
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*100, Ang, 0.35)
				draw.SimpleTextOutlined( 'Drug Dealer', "Trebuchet24", 0, 0, Color( 255, 0,0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))					
			cam.End3D2D()
			
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.35)
			draw.SimpleTextOutlined( 'Touch me with your meth to sell it.', "Trebuchet24", 0, 0, Color( 255, 255,0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))	
			cam.End3D2D()
			
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*90, Ang, 0.35)
			//draw.SimpleTextOutlined( 'Demand: '..ent:GetNetworkedInt("methDemand")..'%', "Trebuchet24", 0, 0, Color( 0, 0,255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))	
			cam.End3D2D()
		end
	end
end)
