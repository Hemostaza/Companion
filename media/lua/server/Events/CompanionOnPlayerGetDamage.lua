local companion = require("CompanionMain");
local function OnPlayerGetDamage(player, damageType, damage)
	--getBodyDamage();
	--print(thatPlayer:getHitForce())
	--if damageType ~= "BLEEDING" then ); end 
	if companionInSecondHand() then
		if bodyDamage then 
			if bodyDamage:getNumPartsBitten() > bittenParts then
				commonDialog("Bite");
				bittenParts=player:getBodyDamage():getNumPartsBitten();
			end
		elseif chance(SandboxVars.Companion.TalkOnGetDamage or 20) then
			if damageType == "BLEEDING" and chance(5) then
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

