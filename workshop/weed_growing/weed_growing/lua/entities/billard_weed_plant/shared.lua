ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Weed Plant"
ENT.Category = "Billard"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsFinishedGrowing")
	self:NetworkVar("Int", 0, "Growth")
end

function ENT:Think()
	if !self:GetIsFinishedGrowing() then
		if self:GetGrowth() < 100 then
			--for k, v in pairs(ents.FindInSphere(self:GetPos(), 300)) do
				--if v:GetClass() == "billard_weed_lamp" then
					self:SetGrowth(self:GetGrowth() + 1)
					self:NextThink(CurTime() + 1)
				--end
			--end
		else
			self:SetIsFinishedGrowing(true)
		end
	end
	return true
end
