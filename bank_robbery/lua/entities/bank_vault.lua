AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Bank Vault"
ENT.Category = "Bank Robbery"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Model = "models/props/cs_assault/MoneyPallet.mdl"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "BeingRobbed")
	self:NetworkVar("Int", 0, "Cooldown")
	self:NetworkVar("Int", 1, "Money")
end

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetMass(60)
		end
		self:SetUseType(SIMPLE_USE or 3)
		if self.PermaMaterial then
			self:SetMaterial(self.PermaMaterial)
		end
		if self.PermaColor then
			self:SetColor(self.PermaColor)
		end
		if self.PermaScale and (self.PermaScale != 1.0) then
			self:SetModelScale(self.PermaScale)
		end
	end
	function ENT:Think()
		if self:GetBeingRobbed() then
			if (self:GetMoney() < 10000) then
				amount = self:GetMoney()
			else
				amount = 10000
			end
			local bag = ents.Create("bank_briefcase")
			bag:SetPos(self:GetPos() + Vector(0, 0, 40))
			bag:Spawn()
			bag:SetMoney(amount)
		else
			self:SetMoney(math.Clamp(self:GetMoney() + 50, 0, 1000000))
			self:SetCooldown(math.Clamp(self:GetCooldown() - 1, , self:GetCooldown()))
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if not caller.isCP then return end

			if caller:isCP() then
				ply:ChatPrint("Only criminals can rob vaults!")
			else
				if self:GetBeingRobbed() then
					caller:ChatPrint("This vault is currently being robbed!")
				else
					if (self:GetCooldown() <= 0) then
						self:SetCooldown(360)
						self:SetBeingRobbed(true)
						BroadcastLua([[chat.AddText(Color(255, 0, 0), "The Bank Vault is being robbed!")]])
					else
						ply:ChatPrint("Please wait "..self:GetCooldown().." seconds.")
					end
				end
			end
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		
		local pos = self:GetPos()
		local maxs = self:LocalToWorld(self:OBBMaxs())
		local mins = self:LocalToWorld(self:OBBMins())
		local ang = self:GetAngles()
		local top
		if (maxs.z > mins.z) then
			top = maxs.z
		else
			top = mins.z
		end

		local stuff = {}

		stuff[#stuff + 1] = {content = ("$"..string.Comma(self:GetMoney())), color = Color(0, 255, 0)}
		stuff[#stuff + 1] = {content = ((self:GetCooldown() <= 0) and "Ready to be robbed!" or "Cooldown: "..self:GetCooldown()), color = Color(255, 0, 0)}
		stuff[#stuff + 1] = {content = self.PrintName, color = Color(255, 255, 255)}

		cam.Start3D2D(Vector(pos.x, pos.y, pos.z + (top - pos.z) - 8), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.125)
			for k, v in pairs(stuff) do
				draw.SimpleTextOutlined(v.content, "Trebuchet24", 0, -100 - (35 * (k - 1)), v.color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25))
			end
		cam.End3D2D()
	end
end
