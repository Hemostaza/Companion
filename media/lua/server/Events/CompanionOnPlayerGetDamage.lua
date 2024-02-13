local companion = require("CompanionMain");
local function OnPlayerGetDamage(player, damageType, damage)
	--getBodyDamage();
	--print(thatPlayer:getHitForce())
	--if damageType ~= "BLEEDING" then ); end 
	if companionInSecondHand() then
		if player:getBodyDamage():getNumPartsBitten() > bittenParts then
			commonDialog("Bite",3);
			bittenParts=player:getBodyDamage():getNumPartsBitten();
		elseif chance(SandboxVars.Companion.TalkOnGetDamage or 20) then
			if damageType == "BLEEDING" and chance(5) then
				commonDialog("Bleeding",3);
			elseif damageType == "THIRST" then
				commonDialog("Dehydration",2)
			elseif damageType == "HUNGRY" then
				commonDialog("StarvingDying",2)
			end
		end
	end
end
Events.OnPlayerGetDamage.Add(OnPlayerGetDamage) --nie odpala sie jak zobie ugryzie

