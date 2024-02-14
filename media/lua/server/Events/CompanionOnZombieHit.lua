local companion = require("CompanionMain");

local function OnHitZombie(zombie, character, bodyPartType, handWeapon)

	if companionInInventory() then
		if companionInMainHand() then
			commonDialog("Destroy",2); -- chuj
			changeToDoll(handWeapon);
			return
		end
		if chance(SandboxVars.Companion.TalkOnZombieHit > 0 and 5 or 0) and ( CheckIfNude(wornItems,false) or CheckIfNude(wornItems,true) ) then--5% szansy podczas bycia nagim
			NudeDialogue(wornItems,"Fight","ShirtlessFight","PantlessFight",1,1,1);
		elseif chance(SandboxVars.Companion.TalkOnZombieHit or 20) then --20% lub ustawienie sandbox
			if companionInSecondHand() then --jeżeli laleczka w drugiej ręce
				local weapCat = handWeapon:getCategories():get(0);
				if ( weapCat=="Improvised" or weapCat=="SmallBlade" or weapCat=="Unarmed" ) and chance(80) then --jeżeli jedna z improwizowanych broni i szansa 80%
					commonDialog("Improvised",3);
				elseif chance(1) then
					ScareDialogue();
				else
					commonDialog("Fight",4);
				end
			else 
				if handWeapon:isRanged() then
					if bodyPartType ~= BodyPartType.Head then
						commonDialog("Aiming",5);
					else 
						if chance(50) then
							commonDialog("Fight",4);
						else
							commonDialog("BeBrave",2);
						end
					end
				else
					if chance(5) then
						damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 5)
						commonDialog("Forgotten",3);
					end
				end
			end
		end
	end
end
Events.OnHitZombie.Add(OnHitZombie)