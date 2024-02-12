local companion = require("CompanionMain");

function OnAIStateChange(character, newState, oldState)
	--print(instanceof(character,"IsoPlayer")); --I don't fuckn know why this wont work in if...
	if character:getClass() == "IsoPlayer" then
		--print("ŁO KURWA KOLIZJA Z ZOMBIE JA PIERDOLE!")
		local stateName = newState:getName();
		print(stateName);
		if companionInHand() and chance(20) then
			if stateName=="ClimbThroughWindowState" then
				if character:isOutside() then
					commonDialog("ThroughWindowIn",2);
				else 
					commonDialog("ThroughWindowOut",3);
				end
			elseif stateName=="OpenWindowState" then
				if character:isOutside() then
					commonDialog("OpenWindowOut",3);
				else 
					commonDialog("OpenWindowIn",1);
				end
			end
		end
	end
	-- przechodzenie przez płoty,  character:isClimbOverWallStruggle() character:isClimbOverWallSuccess()
	--siadanie
	--wstawanie
end
Events.OnAIStateChange.Add(OnAIStateChange)