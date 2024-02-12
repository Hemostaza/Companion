local companion = require("CompanionMain");
local function OnPlayerGetDamage(player, damageType, damage)
	--getBodyDamage();
	if(companionInSecondHand()) and chance(SandboxVars.Companion.TalkOnGetDamage or 50) and damageType == "BLEEDING" then
		commonDialog("Bleeding",3);
	end
end
Events.OnPlayerGetDamage.Add(OnPlayerGetDamage)