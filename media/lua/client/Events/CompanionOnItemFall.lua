local companion = require("CompanionMain");

local function onItemFall(item)
	if item:getType() == "IdnasDoll" then
		updateThatPlayer();
		bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() + 30)
		commonDialog("DropMe"); -- upusciles mnie!
	elseif(companionInSecondHand()) and chance(SandboxVars.Companion.TalkOnDropItem or 80) then
		commonDialog("Drop");
	end
end
Events.onItemFall.Add(onItemFall)

local function OnKeyPressed(key)
	if debugValue then
		if key==Keyboard.KEY_NUMPAD2  then
			canTalk=true;
			print("num 2");
			--RandomAche();
			thatPlayer:dropHandItems();
		end
	end
end
Events.OnKeyPressed.Add(OnKeyPressed)