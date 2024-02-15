local companion = require("CompanionMain");

local function EveryHours()
	canTalk = true;
end
Events.EveryHours.Add(EveryHours)

local function EveryTenMinutes() 
	--updateThatPlayer();
	bittenParts = player:getBodyDamage():getNumPartsBitten();
	wornItems = thatPlayer:getWornItems();
	if canTalk then -- jak może mówić
		if chance(SandboxVars.Companion.TalkOnIdle or 5) and companionInInventory() then --jak chance zwróci true(x% albo 5%) i laleczka jest w ekwipunku
			if companionInHand() then --jak laleczka jest w którejs rece
				if chance(5) and not thatPlayer:isOutside() then --jak chance zwróci true(5%) i gracz jest w budynku
					commonDialog("RandomInside") --dialog
				else 
					if ( CheckIfNude(wornItems,true) or CheckIfNude(wornItems,false) ) and chance(70) then
						NudeDialogue(wornItems,"NudeIdle","ShirtlessIdle","PantlessIdle")
					elseif not MoodleDialogue() and chance(80) then
						commonDialog("Random"); --dialog
					elseif chance(1) then
						ScareDialogue();
					else
						commonDialog("Advice"); --rada.
					end
				end
			else --jeżeli laleczka nie jest w ręku to znaczy że jest tylko w ekwipunku
				if  chance(15) then --15% szanWSsy na to że odjebie jedną z akcji
					RandomAche();
				else
					bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() + 5)
					commonDialog("Forgotten");
				end
			end
		end
		-- jak zombiaki idą za tobą nawet jak laleczka nie może mówić ale jest w rękach.
	elseif (stats:getNumChasingZombies() > 0 or stats:getNumVisibleZombies() > 0) and companionInHand() and chance(20) then
		if chance(98) then
			stats:setPanic(0);
			commonDialog("BeBrave");
		else
			ScareDialogue();
		end
	else --laleczka nie może mówić i nie gonią zombiaki i nie trafi 20%
		local var = SandboxVars.Companion.TalkSensitivity or 50;
		canTalk = ZombRand(100) <= var and true or false
	end
end
Events.EveryTenMinutes.Add(EveryTenMinutes)

local function OnKeyPressed(key)
	if debugValue then
		if key==Keyboard.KEY_NUMPAD1  then
			print("num 1");
			canTalk=true;
			EveryTenMinutes();
		end
	end
end
Events.OnKeyPressed.Add(OnKeyPressed)