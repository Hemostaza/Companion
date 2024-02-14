local companion = require("CompanionMain");

local function OnEquipPrimary(character, inventoryItem)
	if inventoryItem~=nil then --and instanceof(inventoryItem,"HandWeapon")) then print(inventoryItem:getCategories()); end
		if inventoryItem:getName() == "Idnas" and chance(SandboxVars.Companion.TalkOnEquipPrimary or 50) then
			local rand = ZombRand(3);
			if(rand>0) then
				commonDialog("NotWeapon");
			else
				commonDialog("Take");
			end
		elseif(companionInInventory()) then
			if instanceof(inventoryItem,"HandWeapon") and chance(SandboxVars.Companion.TalkOnEquipPrimary or 20) then
				commonDialog("Equip");
			end
		end
	end
end
Events.OnEquipPrimary.Add(OnEquipPrimary)

local function OnEquipSecondary(character, inventoryItem)
	if inventoryItem~=nil then
		if inventoryItem:getName()=="Idnas" and chance(SandboxVars.Companion.TalkOnEquipPrimary or 70) then
			commonDialog("Take");
		end
	end
end
Events.OnEquipSecondary.Add(OnEquipSecondary)