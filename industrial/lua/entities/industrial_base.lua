AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Industrial Base Entity"
ENT.Category = "Industrial Mod"
ENT.Spawnable = false
ENT.Model = "models/Items/combine_rifle_ammo01.mdl"
function ENT:IndustrialType()
	return "base"
	-- valid types and their uses
	-- base - does nothing
	-- gen - generates power
	-- bat - stores power
	-- mach - uses power
end
function ENT:HelpText()
	return "No help text found. Sorry!"
end
function ENT:RefineryData()
	return false
end
function ENT:EngineData()
	return false
end
function ENT:MinerData()
	return false
end
function ENT:ExplodesAfterDamage()
	return 0
end
function ENT:CanTransmitPower()
	return true
end
function ENT:CanGeneratePower()
	return false
end
function ENT:CanReceivePower()
	return true
end
function ENT:PowerTransmitRate()
	return 20
end
function ENT:PowerGenerationRate()
	return 10
end
function ENT:PermaColor()
	return false
end
function ENT:PermaMaterial()
	return false
end
function ENT:EntitySpawnDisplacementVector() -- now THAT's a name!
	return Vector(0, 0, 60)
end
function ENT:DealDamageInRadius()
	return false
end
function ENT:ExtraNetworkedVars() end
function ENT:SetupDataTables()
	if (self:IndustrialType() != "base") then
		self:NetworkVar("Int", 0, "StoredPower")
	end
	if self:RefineryData() then
		local IsRef, Mats, MatAmt, Prod, Tim, Pow, MultiProd = self:RefineryData()
		self:NetworkVar("Int", 1, "StoredMaterial1")
		self:NetworkVar("Int", 2, "StoredMaterial2")
		self:NetworkVar("Int", 3, "StoredMaterial3")
		self:NetworkVar("Int", 4, "StoredProduct")
		if MultiProd then
			self:NetworkVar("Int", 5, "StoredProduct2")
			self:NetworkVar("Int", 6, "StoredProduct3")
		end
		self:NetworkVar("Int", 7, "ConvertCooldown")
	end
	if self:EngineData() then
		self:NetworkVar("Int", 8, "EngineTime")
	end
	if self:MinerData() then
		self:NetworkVar("Int", 9, "MiningCooldown")
		self:NetworkVar("Int", 10, "MinedStuff")
	end
	if (self:ExplodesAfterDamage() > 0) then
		self:NetworkVar("Int", 11, "BoomHealth")
	end
	self:ExtraNetworkedVars()
end
function ENT:HasMaterials()
	local IsRef, Mats, MatAmt, Prod, Tim, Pow = self:RefineryData()
	if (MatAmt == 1) then
		return IsRef and (self:GetStoredMaterial1() > 0)
	elseif (MatAmt == 2) then
		return IsRef and (self:GetStoredMaterial1() > 0) and (self:GetStoredMaterial2() > 0)
	elseif (MatAmt == 3) then
		return IsRef and (self:GetStoredMaterial1() > 0) and (self:GetStoredMaterial2() > 0) and (self:GetStoredMaterial3() > 0)
	else
		return IsRef
	end
end
function ENT:UseMaterials()
	local IsRef, Mats, MatAmt, Prod, Tim, Pow, MultiProd = self:RefineryData()
	if (MatAmt == 1) then
		self:SetStoredMaterial1(self:GetStoredMaterial1() - 1)
	elseif (MatAmt == 2) then
		self:SetStoredMaterial1(self:GetStoredMaterial1() - 1)
		self:SetStoredMaterial2(self:GetStoredMaterial2() - 1)
	elseif (MatAmt == 3) then
		self:SetStoredMaterial1(self:GetStoredMaterial1() - 1)
		self:SetStoredMaterial2(self:GetStoredMaterial2() - 1)
		self:SetStoredMaterial3(self:GetStoredMaterial3() - 1)
	end
end
function ENT:GetMaxStoredPower()
	return 200
end
function ENT:GetInteractionRadius()
	return 80
end
function ENT:CanSeeSky()
	local tr = util.TraceLine({start = self:GetPos(), endpos = self:GetPos() + Vector(0, 0, 2048), filter = self})
	return tr.HitSky
end

if SERVER then
	function ENT:ExtraInit() end
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
		if (self:IndustrialType() != "base") then
			self:SetStoredPower(0)
		end
		if self:EngineData() then
			self:SetEngineTime(0)
		end
		if (self:ExplodesAfterDamage() > 0) then
			self:SetBoomHealth(self:ExplodesAfterDamage())
		end
		self:ExtraInit()
		local IsRef, Mats, MatAmt, Prod, Tim, Pow = self:RefineryData()
		if IsRef then
			self:SetConvertCooldown(Tim)
			self:SetStoredMaterial1(0)
			self:SetStoredMaterial2(0)
			self:SetStoredMaterial3(0)
			self:SetStoredProduct(0)
		end
		local IsMiner, Stuff, IsRandom, mTim, mPow = self:MinerData()
		if IsMiner then
			self:SetMiningCooldown(mTim)
			self:SetMinedStuff(0)
		end
	end
	function ENT:OnEntityUsed(ply) end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			self:OnEntityUsed(caller)
			-- spit out product
			if self:RefineryData() then
				local IsRef, Mats, MatAmt, Prod, Tim, Pow, MultiProd = self:RefineryData()
				if (self:GetStoredProduct() > 0) then
					self:SetStoredProduct(self:GetStoredProduct() - 1)
					local ent = ents.Create(Prod[1] or Prod)
					ent:SetPos(self:GetPos() + self:EntitySpawnDisplacementVector())
					ent:Spawn()
				end
				if MultiProd then
					if Prod[2] and (self:GetStoredProduct2() > 0) then
						self:SetStoredProduct2(self:GetStoredProduct2() - 1)
						local ent = ents.Create(Prod[2] or Prod)
						ent:SetPos(self:GetPos() + self:EntitySpawnDisplacementVector())
						ent:Spawn()
					end
					if Prod[3] and (self:GetStoredProduct3() > 0) then
						self:SetStoredProduct3(self:GetStoredProduct3() - 1)
						local ent = ents.Create(Prod[3] or Prod)
						ent:SetPos(self:GetPos() + self:EntitySpawnDisplacementVector())
						ent:Spawn()	
					end
				end
			end
			-- spit out mined stuff
			if self:MinerData() and (self:GetMinedStuff() > 0) then
				self:SetMinedStuff(math.Clamp(self:GetMinedStuff() - 1, 0, self:GetMinedStuff()))
				local IsMiner, Stuff, IsRandom, Tim, Pow = self:MinerData()
				if IsRandom then
					local ent = ents.Create(Stuff[math.random(1, #Stuff)])
					ent:SetPos(self:GetPos() + self:EntitySpawnDisplacementVector())
					ent:Spawn()
				else
					local ent = ents.Create(Stuff[1])
					ent:SetPos(self:GetPos() + self:EntitySpawnDisplacementVector())
					ent:Spawn()
				end
			end
		end
	end
	function ENT:ExtraThink() end
	function ENT:Think()
		if (self:IndustrialType() != "base") then
			-- send power
			for k, v in pairs(ents.FindInSphere(self:GetPos(), self:GetInteractionRadius())) do
				if IsValid(v) and (v.IndustrialType != nil) then
					if (self:IndustrialType() == "bat") and (v:IndustrialType() == "mach") then
						if self:CanTransmitPower() and v:CanReceivePower() then
							local amt = math.Clamp(self:PowerTransmitRate(), 0, math.Min(self:GetStoredPower(), v:GetMaxStoredPower() - v:GetStoredPower()))
							self:SetStoredPower(self:GetStoredPower() - amt)
							v:SetStoredPower(v:GetStoredPower() + amt)
						end
					end
					if (self:IndustrialType() == "gen") or ((v:IndustrialType() == "bat") or (v:IndustrialType() == "mach")) then
						if self:CanTransmitPower() and v:CanReceivePower() then
							local amt = math.Clamp(self:PowerTransmitRate(), 0, math.Min(self:GetStoredPower(), v:GetMaxStoredPower() - v:GetStoredPower()))
							self:SetStoredPower(self:GetStoredPower() - amt)
							v:SetStoredPower(v:GetStoredPower() + amt)
						end
					end
				end
			end
			-- generate power
			if self:CanGeneratePower() or (self:GetEngineTime() > 0) then
				self:SetStoredPower(math.Clamp(self:GetStoredPower() + self:PowerGenerationRate(), 0, self:GetMaxStoredPower()))
			end
			-- refine materials
			if self:RefineryData() then
				local IsRef, Mats, MatAmt, Prod, Tim, Pow, MultiProd = self:RefineryData()
				if (self:GetStoredPower() >= Pow) and (self:HasMaterials()) then
					self:SetStoredPower(self:GetStoredPower() - Pow)
					self:SetConvertCooldown(math.Clamp(self:GetConvertCooldown() - 1, 0, self:GetConvertCooldown()))
				end
				if (self:GetConvertCooldown() <= 0) then
					if self:HasMaterials() and (not MultiProd) then
						self:UseMaterials()
						self:SetConvertCooldown(Tim)
						self:SetStoredProduct(self:GetStoredProduct() + 1)
					end
					if (self:GetStoredMaterial1() > 0) and MultiProd then
						self:SetMaterial1(math.Clamp(self:GetMaterial1() - 1, 0, self:GetMaterial1()))
						self:SetConvertCooldown(Tim)
						self:SetStoredProduct(self:GetStoredProduct() + 1)
					end
					if (self:GetStoredMaterial2() > 0) and MultiProd then
						self:SetMaterial2(math.Clamp(self:GetMaterial2() - 1, 0, self:GetMaterial2()))
						self:SetConvertCooldown(Tim)
						self:SetStoredProduct2(self:GetStoredProduct2() + 1)
					end
					if (self:GetStoredMaterial3() > 0) and MultiProd then
						self:SetMaterial3(math.Clamp(self:GetMaterial3() - 1, 0, self:GetMaterial3()))
						self:SetConvertCooldown(Tim)
						self:SetStoredProduct3(self:GetStoredProduct3() + 1)
					end
				end
			end
			-- engine time
			if self:EngineData() then
				self:SetEngineTime(math.Clamp(self:GetEngineTime() - 1, 0, self:GetEngineTime()))
			end
			-- mine stuff
			if self:MinerData() then
				local IsMiner, Stuff, IsRandom, Tim, Pow = self:MinerData()
				if (self:GetStoredPower() >= Pow) then
					self:SetStoredPower(self:GetStoredPower() - Pow)
					self:SetMiningCooldown(math.Clamp(self:GetMiningCooldown() - 1, 0, self:GetMiningCooldown()))
				end
				if (self:GetMiningCooldown() <= 0) then
					self:SetMiningCooldown(Tim)
					self:SetMinedStuff(self:GetMinedStuff() + 1)
				end
			end
			-- deal damage in radius
			if self:DealDamageInRadius() then
				local Radius, Dmg = self:DealDamageInRadius()
				for k, v in pairs(ents.FindInSphere(self:GetPos(), Radius)) do
					if v:IsPlayer() then
						v:DealDamage(Dmg, self, self)
					end
				end
			end
		end
		-- set color 
		if self:PermaColor() then
			self:SetColor(self:PermaColor())
		end
		-- set material
		if self:PermaMaterial() then
			self:SetMaterial(self:PermaMaterial())
		end
		-- set next think
		self:ExtraThink()
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:ExtraTouch(toucher) end
	function ENT:Touch(toucher)
		-- refinery materials
		if self:RefineryData() then
			local IsRef, Mats, MatAmt, Prod, Tim, Pow = self:RefineryData()
			for k, v in pairs(Mats) do
				if (toucher:GetClass() == v) then
					SafeRemoveEntity(toucher)
					if (k == 1) then
						self:SetStoredMaterial1(self:GetStoredMaterial1() + 1)
					elseif (MatAmt > 1) and (k == 2) then
						self:SetStoredMaterial2(self:GetStoredMaterial2() + 1)
					elseif (MatAmt > 2) ans (k == 3) then
						self:SetStoredMaterial3(self:GetStoredMaterial3() + 1)
					end
				end
			end
		end
		-- engine fuel
		if self:EngineData() then
			local IsEng, Fuels, Times = self:EngineData()
			for k, v in pairs(Fuels) do
				if (toucher:GetClass() == v) then
					SafeRemoveEntity(toucher)
					self:SetEngineTime(self:GetEngineTime() + Times[k])
				end
			end
		end
	end
	function ENT:ExtraOnTakeDamage()
	function ENT:OnTakeDamage(dmg)
		self:SetBoomHealth(self:GetBoomHealth() - dmg:GetDamage())
		if (self:GetBoomHealth() <= 0) and (self:ExplodesAfterDamage() > 0) then
			local boom = EffectData()
			boom:SetOrigin(self:GetPos())
			util.Effect("HelicopterMegaBomb", boom)
			self:EmitSound("weapons/explode"..math.random(3, 5)..".wav")
			util.BlastDamage(self, self, self:GetPos(), 128, 100)
			SafeRemoveEntity(self)
		end
		self:ExtraOnTakeDamage()
	end
end
end
if CLIENT then
	-- puny client functions
	function ENT:Draw()
		self:DrawModel()
	end
	-- todo: menus
end
