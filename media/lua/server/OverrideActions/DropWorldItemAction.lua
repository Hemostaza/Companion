local companion = require("CompanionMain");

dropWorldItem = ISDropWorldItemAction.start

function ISDropWorldItemAction:start()    
    dropWorldItem(self)  
	if companionInInventory() and self.item:getName() == "Idnas" then
		damage = thatPlayer:getBodyDamage();
		damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 30)
		commonDialog("PutAway",3);
		--print(self.item);
	end
	--doSomething(self.item, self.character)
end
