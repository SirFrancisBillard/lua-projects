local meta = FindMetaTable("Player")

function meta:GiveItem(id, am)
	local amount = 1
	if am then
		amount = am
	end
	self:GiveAmmo(amount, id, false)
end

function meta:TakeItem(id, am)
	local amount = 1
	if am then
		amount = am
	end
	self:RemoveAmmo(amount, id)
end
