AddCSLuaFile()
ENT.Base = AML_CLASS_BASE
ENT.PrintName = "#aml.base_ingredient.name"
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = false
ENT.Model = "models/Items/combine_rifle_ammo01.mdl"
ENT.TextColor = Color(255, 255, 255, 255)
ENT.OutlineColor = Color(25, 25, 25, 255)
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
		
		cam.Start3D2D(Vector(pos.x, pos.y, pos.z + (top - pos.z) - 8), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.125)
			draw.SimpleTextOutlined(self.PrintName, "Trebuchet24", 8, -98, self.TextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, self.OutlineColor)
		cam.End3D2D()
	end
end
