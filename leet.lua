LEET = {}

LEET.EnglishToLeet = {}
LEET.LeetToEnglish = {}

LEET.English = {}
LEET.Leet = {}

function LEET.AddLetter(en, leet)
	if type(en) ~= "string" or type(leet) ~= "string" then return end
	LEET.EnglishToLeet[en] = leet
	LEET.LeetToEnglish[leet] = en
	LEET.English[#LEET.English + 1] = en
	LEET.Leet[#LEET.Leet + 1] = leet
end

function LEET.TranslateToLeet(str, num_times)
	if type(str) ~= "string" then return str end
	if num_times == nil then num_times = 1 end
	if num_times > #LEET.English or num_times > #LEET.Leet then return str end
	return LEET.TranslateToLeet(str:lower():gsub(LEET.English[num_times], LEET.Leet[num_times]), num_times + 1)
end

LEET.AddLetter("a", "4")
LEET.AddLetter("b", "6")
LEET.AddLetter("e", "3")
LEET.AddLetter("i", "1")
LEET.AddLetter("l", "|_")
LEET.AddLetter("m", "|V|")
LEET.AddLetter("n", "|\\|")
LEET.AddLetter("o", "0")
LEET.AddLetter("s", "5")
LEET.AddLetter("t", "7")
LEET.AddLetter("v", "\\/")
LEET.AddLetter("w", "\\/\\/")

