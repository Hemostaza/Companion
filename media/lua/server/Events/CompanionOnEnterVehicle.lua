local companion = require("CompanionMain");

local function OnEnterVehicle(character)
	if(companionInHand()) and chance(SandboxVars.Companion.TalkOnZombieCollide or 50) then
		commonDialog("EnterVehicle",3);
	end
end
Events.OnEnterVehicle.Add(OnEnterVehicle)