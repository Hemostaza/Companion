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