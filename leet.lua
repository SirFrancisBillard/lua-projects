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
	return LEET.TranslateToLeet(str:gsub(LEET.English[num_times], LEET.Leet[num_times]), num_times + 1)
end

LEET.AddLetter("a", "x")
LEET.AddLetter("b", "y")
LEET.AddLetter("c", "z")
