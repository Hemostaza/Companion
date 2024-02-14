local companion = require("CompanionMain");

inventoryTransfer = ISInventoryTransferAction.start

function ISInventoryTransferAction:start()    
    inventoryTransfer(self)  
		print("transfer perform")
	--	print("perform on item",self.item:getName())
	player = self.character;
	if(player~=nil) then 
		--print("kompanion w inverto",companionInInventory(chara));
		if companionInInventory() then
			if self.srcContainer:getType() == "none" then
				if self.item:getName() == "Idnas" then
					updateThatPlayer();
					stats:setAnger(10);
					damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 60)
					commonDialog("ThrowAway");
				elseif chance(SandboxVars.Companion.TalkOnThrowItem or 5) and companionInSecondHand() then 
					commonDialog("ThrowRandom");
				end
			end
		end
	end
end