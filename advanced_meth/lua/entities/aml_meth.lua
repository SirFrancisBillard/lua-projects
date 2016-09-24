AddCSLuaFile()
ENT.Base = AML_CLASS_BASE
ENT.PrintName = AML_NAME_CRYSTAL_METH
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = AML_SPAWNABLE
ENT.AdminSpawnable = AML_SPAWNABLE_ADMIN
ENT.Model = AML_MODEL_CRYSTAL_METH
ENT.PermaColor = Color(0, 255, 255)
ENT.PermaMaterial = "models/debug/debugwhite"
ENT.TextColor = Color(0, 255, 255)
ENT.OutlineColor = Color(0, 0, 0)
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Purity")
	self:NetworkVar("Int", 1, "UsedRedPhos")
	self:NetworkVar("Int", 2, "UsedLye")
	self:NetworkVar("Int", 3, "UsedFlour")
	self:NetworkVar("Int", 4, "Purity")
end
if SERVER then
	function ENT:Think()
		local purity = 100
		local difference = 0
		if (self:GetUsedRedPhos() > AML_PURITY_AMOUNT_RED_PHOSPHORUS) then
			difference = (self:GetUsedRedPhos() - AML_PURITY_AMOUNT_RED_PHOSPHORUS)
		else
			difference = (AML_PURITY_AMOUNT_RED_PHOSPHORUS - self:GetUsedRedPhos())
		end
		purity = (purity - difference)
		if (self:GetUsedLye() > AML_PURITY_AMOUNT_LYE_SOLUTION) then
			difference = (self:GetUsedLye() - AML_PURITY_AMOUNT_LYE_SOLUTION)
		else
			difference = (AML_PURITY_AMOUNT_LYE_SOLUTION - self:GetUsedLye())
		end
		purity = (purity - difference)
		if (self:GetUsedFlour() > AML_PURITY_AMOUNT_FLOUR) then
			difference = (self:GetUsedFlour() - AML_PURITY_AMOUNT_FLOUR)
		else
			difference = (AML_PURITY_AMOUNT_FLOUR - self:GetUsedFlour())
		end
		purity = (purity - difference)
		self:SetPurity(purity)
		self:NextThink(CurTime() + 0.2)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if (not AML_CONFIG_NEED_DEALER) then
				if (not caller.addMoney) then return end
				caller:addMoney(AML_CONFIG_METH_PRICE * (self:GetPurity() / 100))
				SafeRemoveEntity(self)
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
		stuff[#stuff + 1] = "Purity: "..self:GetPurity().."%"
		stuff[#stuff + 1] = self.PrintName

		cam.Start3D2D(Vector(pos.x, pos.y, pos.z + (top - pos.z) - 8), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.125)
			for k, v in pairs(stuff) do
				draw.SimpleTextOutlined(v, "Trebuchet24", 0, -100 - (35 * (k - 1)), self.TextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, self.OutlineColor)
			end
		cam.End3D2D()
	end
end