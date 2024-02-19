local companion = require("CompanionMain");

dropWorldItem = ISDropWorldItemAction.start

function ISDropWorldItemAction:start()    
    dropWorldItem(self)  
	if companionInInventory() and self.item:getType() == "IdnasDoll" then
		--damage = thatPlayer:getBodyDamage();
		bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() + 30)
		commonDialog("PutAway");
		--print(self.item);
	end
	--doSomething(self.item, self.character)
end
