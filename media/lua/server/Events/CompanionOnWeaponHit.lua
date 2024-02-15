local companion = require("CompanionMain");

local function OnWeaponSwingHitPoint(character, handWeapon, thumpable)
	if handWeapon:getType() == "IdnasDoll" then -- jak piźnie w drzwi.
        character:dropHandItems()
    end
end

Events.OnWeaponHitThumpable.Add(OnWeaponSwingHitPoint)