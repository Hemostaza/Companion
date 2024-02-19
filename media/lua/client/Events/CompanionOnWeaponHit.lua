local companion = require("CompanionMain");

local function OnWeaponSwingHitPoint(character, handWeapon, thumpable)
    if handWeapon then
	    if handWeapon:getType() == "IdnasDoll" then -- jak piźnie w drzwi.
            character:dropHandItems()
        end
    end
end

Events.OnWeaponHitThumpable.Add(OnWeaponSwingHitPoint)