AddCSLuaFile()

SWEP.Base = "weapon_sck_base"

SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.PrintName = "Newspaper"
SWEP.Purpose = "What's going on in the world today?"
SWEP.Category = "Roleplay Weapons"

SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = ""

SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["Detonator"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
	["Slam_panel"] = {scale = Vector(0.996, 0.996, 0.996), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
	["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, 1.493, -30), angle = Angle(0, 0, 0)},
	["Slam_base"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0.009, 0.009, 3), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)}
}

SWEP.VElements = {
	["paper"] = {type = "Model", model = "models/props_junk/garbage_newspaper001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.37, 3.904, -3.547), angle = Angle(84.832, 49.483, 6.363), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}}
}

SWEP.WElements = {
	["paper"] = {type = "Model", model = "models/props_junk/garbage_newspaper001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.519, 5.426, -2.177), angle = Angle(93.78, 0, 1.71), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}}
}

local FirstNames = {
	"William",
	"Robert",
	"Alex",
	"Joseph",
	"Lewis",
	"James",
	"Donald",
	"Christopher",
	"Murray",
	"Helena",
	"Sarah",
	"Mary",
	"MaryAnn",
	"Prudence",
	"Glenn",
	"Roy",
	"Gladyss",
	"Jackson",
	"Kim",
	"Hillary",
	"Falco",
	"Nicholas",
	"Timothy",
	"Phillip",
	"Hannah",
	"Alexander",
	"Thomas",
	"Edward",
	"Andrew"
}

local LastNames = {
	"Murray",
	"Hanks",
	"Smith",
	"White",
	"Green",
	"Edwards",
	"Johnson",
	"Johnston",
	"Myashiro",
	"Jones",
	"Lane",
	"Brindley",
	"Jong Un",
	"Allen"
}

local Starts = {
	"Florida man",
	"Florida woman",
	"Billy Mays",
	"Animal rights activist",
	"Twitch streamer",
	"Feminist",
	"Trump supporter",
	"Nigerian Prince",
	"Santa Claus"
}

local Middles = {
	"eats seventeen cheetos",
	"eats entire swedish family",
	"consumes the entirety of IKEA's furniture",
	"uses public restroom",
	"assassinated",
	"gives birth",
	"declares terrorist attack",
	"leaves the EU",
	"joins ISIS",
	"commits suicide",
	"build wall",
	"eats twenty tacos",
	"eats eight pound burrito",
	"wins lottery",
	"commits mass genocide",
	"goes on murderous rampage",
	"to star in lead role",
	"builds spaceship"
}

local Ends = {
	"while underwater",
	"while drunk",
	"for breast cancer awareness week",
	"twelve times",
	"eighteen times"
	"inside public restroom",
	"during sexual intercourse",
	"in mexico",
	"while skydiving",
	"in space",
	"on the moon"
}

local Default = {
	"Let's see the headlines for today...",
	"Well that was... interesting."
}

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "Stories")
end

function SWEP:Initialize()
	self.BaseClass.Initialize(self)
	self:SetStories(5)
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	if self:GetStories() > 0 then
		if self:GetStories() == 5 then
			self.Owner:ChatPrint(Default[1])
			self:SetStories(self:GetStories() - 1)
		else
			self.Owner:ChatPrint("\"" .. (math.random(1, 3) == 1 and Starts[math.random(1, #Starts)] or FirstNames[math.random(1, #FirstNames)] .. " " .. LastNames[math.random(1, #LastNames)]) .. " " .. Middles[math.random(1, #Middles)] .. " " .. Ends[math.random(1, #Ends)] .. "\"")
			self:SetStories(self:GetStories() - 1)
		end
	else
		self.Owner:ChatPrint(Default[2])
		self:Remove()
	end
end
