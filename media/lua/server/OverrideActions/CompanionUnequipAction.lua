local companion = require("CompanionMain");
unequipItemsAction = ISUnequipAction.perform
function ISUnequipAction:perform()
	unequipItemsAction(self)
	unequipedItem = self.item:getBodyLocation();
	if companionInHand() and (tableContains(upperLocations, unequipedItem) 
			or tableContains(lowerLocations, unequipedItem) ) then
		return NudeDialogue(self.character:getWornItems() ,"TakeOff","TakeOffShirt","TakeOffPants")
	end
end