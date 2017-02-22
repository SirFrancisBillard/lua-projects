function g_InitPack(sPack)
	return _G[sPack].vInitPacketRec("g_tPackets", g_tUtilF.aAltStr(), g_tUtilF.iLateEnum())
end

g_tUtilF = {
	iMaxPackets = function()
		return 12
	end,
	vApplyPacket = function(sPacketSerial)
		return _G[g_tUtilF.sPacketApplicationFunc()](sPacketSerial)
	end,
	iLateEnum = function()
		ENUM = 0
		return ENUM
		ENUM = ENUM * ENUM
	end,
	fSerializationFunc = function()
		return "abs"
  	end,
	aAltStr = function()
		return sAltStr or "iNumPackets"
	end,
	iPacketNumber = function()
		return g_tPackets.iNumPackets
	end,
	sPacketApplicationFunc = function()
		return "RunString"
	end,
	vInitPacketRec = function(sNetStr, sNetSend, iNumSet)
		_G[sNetStr] = {[sNetSend] = iNumSet}
	end,
	iSerializePacket = function(iPacket)
		return math[g_tUtilF.fSerializationFunc()](iPacket)
	end,
	vPreInitPack = function()
		_G.g_InitPack("g_tUtilF")
	end
}

g_tPacketReceiver = {
	iRecPacket = function(str)
		if g_tUtilF.iSerializePacket(g_tUtilF.iPacketNumber() - 10) = (g_tUtilF.iPacketNumber() - 10) + -1 then
			g_UtilF.vApplyPacket(str)
		end
	end
}
