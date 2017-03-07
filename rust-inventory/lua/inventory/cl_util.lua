
function GetRowColumnFromItemSlot(slot)
	local row = math.floor(slot / 6)
	local column = slot % 6
	if column == 0 then
		column = 6
	end
	return row, column
end

function GetScreenPosFromRowColumn(row, column)
	-- TODO
	local x, y = row * 2, column *2
	return x, y
end
