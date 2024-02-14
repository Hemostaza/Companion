local companion = require("CompanionMain");

function OnAIStateChange(character, newState, oldState)
	--print(instanceof(character,"IsoPlayer")); --I don't fuckn know why this wont work in if...
	--print(kurwamac);
	-- print(newState, "KURWA NIE JEST NULLEM ",newState,newState,newState)
	-- print(newState," kurwa czym jest newstate" );  --fucking fuck newState was not null but even getClass() won't work. I'm stupid or something?
	if instanceof(character,"IsoPlayer") then
		print(character:getActionStateName());
		local actionName = character:getActionStateName();
		if companionInHand() and chance(20) then
			if actionName=="climbwindow" then
				if character:isOutside() then
					commonDialog("ThroughWindowIn");
				else 
					commonDialog("ThroughWindowOut");
				end
			elseif actionName=="openwindow" then
				if character:isOutside() then
					commonDialog("OpenWindowOut");
				else 
					commonDialog("OpenWindowIn");
				end
			end
		end
	end
	-- przechodzenie przez płoty,  character:isClimbOverWallStruggle() character:isClimbOverWallSuccess()
	--siadanie
	--wstawanie
end
Events.OnAIStateChange.Add(OnAIStateChange)