AddCSLuaFile()
ENT.Base = "aml_base"
ENT.PrintName = "Meth Cooking Base Ingredient"
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = false
ENT.Model = "models/Items/combine_rifle_ammo01.mdl"
ENT.TextColor = Color(255, 255, 255, 255)
ENT.OutlineColor = Color(25, 25, 25, 255)
if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		
		local bbox = self:OBBMaxs()
		local ang = self:GetAngles()
		
		cam.Start3D2D(Vector(0, 0, bbox.z) + Vector(0, 0, 6), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.125)
			draw.SimpleTextOutlined(self.PrintName, "Trebuchet24", 8, -98, self.TextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, self.OutlineColor)
		cam.End3D2D()
	end
end
