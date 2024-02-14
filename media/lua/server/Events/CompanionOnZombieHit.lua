local companion = require("CompanionMain");

local function OnHitZombie(zombie, character, bodyPartType, handWeapon)

	if companionInInventory() then
		if companionInMainHand() then
			commonDialog("Destroy"); -- chuj
			changeToDoll(handWeapon);
			return
		end
		if chance(SandboxVars.Companion.TalkOnZombieHit > 0 and 5 or 0) and ( CheckIfNude(wornItems,false) or CheckIfNude(wornItems,true) ) then--5% szansy podczas bycia nagim
			NudeDialogue(wornItems,"NudeFight","ShirtlessFight","PantlessFight");
		elseif chance(SandboxVars.Companion.TalkOnZombieHit or 20) then --20% lub ustawienie sandbox
			if companionInSecondHand() then --jeżeli laleczka w drugiej ręce
				local weapCat = handWeapon:getCategories():get(0);
				if ( weapCat=="Improvised" or weapCat=="SmallBlade" or weapCat=="Unarmed" ) and chance(80) then --jeżeli jedna z improwizowanych broni i szansa 80%
					commonDialog("Improvised");
				elseif chance(1) then
					ScareDialogue();
				else
					commonDialog("Fight");
				end
			else 
				if handWeapon:isRanged() then
					if bodyPartType ~= BodyPartType.Head then
						commonDialog("Aiming");
					else 
						if chance(50) then
							commonDialog("Fight");
						else
							commonDialog("BeBrave");
						end
					end
				else
					if chance(5) then
						damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 5)
						commonDialog("Forgotten");
					end
				end
			end
		end
	end
end
Events.OnHitZombie.Add(OnHitZombie)