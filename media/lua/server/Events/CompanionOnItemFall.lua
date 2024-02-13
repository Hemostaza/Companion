local companion = require("CompanionMain");

local function onItemFall(item)
	if item:getName() == "Idnas" then
		updateThatPlayer();
		damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 30)
		commonDialog("DropMe",3); -- upusciles mnie!
	elseif(companionInSecondHand()) and chance(SandboxVars.Companion.TalkOnDropItem or 80) then
		commonDialog("Drop",2);
	end
end
Events.onItemFall.Add(onItemFall)

local function OnKeyPressed(key)
	if debugValue then
		if key==Keyboard.KEY_NUMPAD2  then
			canTalk=true;
			print("num 2");
			--RandomAche();
			dropHandItems();
		end
	end
end
Events.OnKeyPressed.Add(OnKeyPressed)