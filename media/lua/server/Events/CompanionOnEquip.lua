local companion = require("CompanionMain");

local function OnEquipPrimary(character, inventoryItem)
	if inventoryItem~=nil then --and instanceof(inventoryItem,"HandWeapon")) then print(inventoryItem:getCategories()); end
		if inventoryItem:getName() == "Idnas" then
			local rand = ZombRand(3);
			if(rand>0) then
				commonDialog("NotWeapon",2);
			else
				commonDialog("Take",4);
			end
		elseif(companionInInventory()) then
			if instanceof(inventoryItem,"HandWeapon") and chance(SandboxVars.Companion.TalkOnEquipPrimary or 20) then
				commonDialog("Equip",4);
			end
		end
	end
end
Events.OnEquipPrimary.Add(OnEquipPrimary)

local function OnEquipSecondary(character, inventoryItem)
	if inventoryItem~=nil then
		if inventoryItem:getName()=="Idnas" then
			commonDialog("Take",4);
		end
	end
end
Events.OnEquipSecondary.Add(OnEquipSecondary)