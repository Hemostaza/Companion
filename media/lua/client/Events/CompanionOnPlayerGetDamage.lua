local companion = require("CompanionMain");
local function OnPlayerGetDamage(player, damageType, damage)
	--getBodyDamage();
	--print(thatPlayer:getHitForce())
	--if damageType ~= "BLEEDING" then ); end 
	if companionInSecondHand() then
		if player:getBodyDamage():getNumPartsBitten() > bittenParts and canTalk then
			commonDialog("Bite");
			bittenParts=player:getBodyDamage():getNumPartsBitten();
		elseif chance(SandboxVars.Companion.TalkOnGetDamage or 20) then
			if damageType == "BLEEDING" and chance(1) then
				commonDialog("Bleeding");
			elseif damageType == "THIRST" then
				commonDialog("DehydrationDying")
			elseif damageType == "HUNGRY" then
				commonDialog("StarvingDying")
			end
		end
	end
end
Events.OnPlayerGetDamage.Add(OnPlayerGetDamage) --nie odpala sie jak zobie ugryzie

