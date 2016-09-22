AddCSLuaFile()
ENT.Base = "aml_base"
ENT.PrintName = "Meth Cooking Base Ingredient"
ENT.Category = "Meth Cooking"
ENT.Spawnable = false
ENT.Model = "models/Items/combine_rifle_ammo01.mdl"
if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		
		local pos = self:GetPos()
		local ang = self:GetAngles()
		
		cam.Start3D2D(pos + Vector(0, 0, 16), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.125)
			draw.SimpleTextOutlined(self.PrintName, "Trebuchet24", 8, -98, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 100))
		cam.End3D2D()
	end
end