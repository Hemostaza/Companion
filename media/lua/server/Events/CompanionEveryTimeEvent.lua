local companion = require("CompanionMain");

local function EveryHours()
	canTalk = true;
end
Events.EveryHours.Add(EveryHours)

local function EveryTenMinutes() 
	updateThatPlayer();
	wornItems = thatPlayer:getWornItems();
	if canTalk then -- jak może mówić
		if chance(SandboxVars.Companion.TalkOnIdle or 5) and companionInInventory() then --jak chance zwróci true(x% albo 5%) i laleczka jest w ekwipunku
			if companionInHand() then --jak laleczka jest w którejs rece
				if chance(5) and not thatPlayer:isOutside() then --jak chance zwróci true(5%) i gracz jest w budynku
					commonDialog("RandomInside",1) --dialog
				else 
					if ( CheckIfNude(wornItems,true) or CheckIfNude(wornItems,false) ) and chance(70) then
						NudeDialogue(wornItems,"Idle","NudeTakeOffShirt","IdlePantless",2,1,1)
					else
						commonDialog("Random",6); --dialog
					end
				end
			else --jeżeli laleczka nie jest w ręku to znaczy że jest tylko w ekwipunku
				if  chance(15) then --15% szanWSsy na to że odjebie jedną z akcji
					RandomAche();
				else
					damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 50)
					commonDialog("Forgotten",2);
				end
			end
		end
		-- jak zombiaki idą za tobą nawet jak laleczka nie może mówić ale jest w rękach.
	elseif (stats:getNumChasingZombies() > 0 or stats:getNumVisibleZombies() > 0) and companionInHand() then
		stats:setPanic(0);
		commonDialog("BeBrave",1);
	else --laleczka nie może mówić i nie gonią zombiaki
		local var = SandboxVars.Companion.TalkSensitivity or 50;
		canTalk = ZombRand(100) <= var and true or false
	end
end
Events.EveryTenMinutes.Add(EveryTenMinutes)

local function OnKeyPressed(key)
	print(key);
	if debugValue then
		if key==31 then
			canTalk=true;
			--RandomAche();
			EveryTenMinutes();
		end
	end
end
Events.OnKeyPressed.Add(OnKeyPressed)