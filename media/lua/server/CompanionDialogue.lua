function initialize(playerIndex, player)
	thatPlayer = player;
	stats = thatPlayer:getStats();
	damage = thatPlayer:getBodyDamage();
	wornItems = thatPlayer:getWornItems();

	emitter = thatPlayer:getEmitter();
	playerColor = thatPlayer:getSpeakColour();
	idnasColor = Color.red;
	print(thatPlayer:getName());
	--if debugValue then
		--inventory:addItem(inventory:AddItem("Companion.Idnas"));
	--end
	canTalk = false;
	audio = 1;

	debugValue = SandboxVars.Companion.DebugOption or false;

	lowerLocations = {
		"Underwear",
		"UnderwearBottom",
		"UnderwearExtra1",
		"UnderwearExtra2",
		"Legs1",
		"Pants",
		"Skirt",
		"Legs5",
		"Dress"
	}
	upperLocations ={
		"Torso1",
		"Torso1Legs1",
		"TankTop",
		"Tshirt",
		"ShortSleeveShirt",
		"Shirt",
		"BodyCostume",
		"Sweater",
		"SweaterHat",
		"Jacket",
		"Jacket_Down",
		"Jacket_Bulky",
		"JacketHat",
		"JacketSuit",
		"FullSuit",
		"Boilersuit",
		"FullSuitHead",
		"FullTop",
		"BathRobe",
		"TorsoExtra",
		"TorsoExtraVest"
	}
	
end
Events.OnCreatePlayer.Add(initialize);

function tableContains(table, value)
	for i = 1,#table do
	  if (table[i] == value) then
		return true
	  end
	end
	return false
  end

function companionInInventory()
	if(instanceof(thatPlayer,"IsoPlayer")) then
		itis = thatPlayer:getInventory():contains("Idnas");
		return itis;
	else 
		return false;
	end
end

function companionInSecondHand()
	if thatPlayer:getSecondaryHandItem() then
		return thatPlayer:getSecondaryHandItem():getName()=="Idnas";
	else return false end
end

function companionInMainHand()
	if thatPlayer:getPrimaryHandItem() then
		return thatPlayer:getPrimaryHandItem():getName()=="Idnas";
	else return false end
end

function companionInHand()
	if companionInMainHand() or companionInSecondHand() then
		return true;
	else return false end
end

function updateThatPlayer()
	stats = thatPlayer:getStats();
	damage = thatPlayer:getBodyDamage();
end

function changeToDoll(remIdnas)
	thatPlayer:getInventory():AddItem("Doll");
	thatPlayer:setPrimaryHandItem(nil);
	thatPlayer:getInventory():Remove(remIdnas);
	updateThatPlayer();
	stats:setAnger(1);
	damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 60)
end

function chance(value)
	if debugValue and not emitter:isPlaying(audio) then
		--return true
	end
	if(canTalk == true) and not emitter:isPlaying(audio) then
		local rand = ZombRand(100);
		if(value>rand) then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

local function OnCharacterCollide(player, character)
	if(instanceof(player,"IsoPlayer")) then
		if companionInHand() then
			--kolizja gracza z zombie
			if(instanceof(character,"IsoZombie")) and
				chance(SandboxVars.Companion.TalkOnZombieCollide or 20) then 
				CommonDialog("Collision",4);
			else 
				--jeżeli kolizja między graczami
			end
		end
	end
end
Events.OnCharacterCollide.Add(OnCharacterCollide)

local function OnEnterVehicle(character)
	if(companionInHand()) and chance(SandboxVars.Companion.TalkOnZombieCollide or 50) then
		CommonDialog("EnterVehicle",3);
	end
end
Events.OnEnterVehicle.Add(OnEnterVehicle)

local function OnPlayerMove(player)
-- getMoodles()
end
Events.OnPlayerMove.Add(OnPlayerMove)

local function OnClothingUpdated(character)
	
end
Events.OnClothingUpdated.Add(OnClothingUpdated)

local function OnEquipPrimary(character, inventoryItem)
	if inventoryItem~=nil then --and instanceof(inventoryItem,"HandWeapon")) then print(inventoryItem:getCategories()); end
		if inventoryItem:getName() == "Idnas" then
			local rand = ZombRand(3);
			if(rand>0) then
				CommonDialog("NotWeapon",2);
			else
				CommonDialog("Take",4);
			end
		elseif(companionInInventory()) then
			if instanceof(inventoryItem,"HandWeapon") and chance(SandboxVars.Companion.TalkOnEquipPrimary or 20) then
				CommonDialog("Equip",4);
			end
		end
	end
end
Events.OnEquipPrimary.Add(OnEquipPrimary)

local function OnEquipSecondary(character, inventoryItem)
	if inventoryItem~=nil then
		if inventoryItem:getName()=="Idnas" then
			CommonDialog("Take",4);
		end
	end
end
Events.OnEquipSecondary.Add(OnEquipSecondary)

local function OnHitZombie(zombie, character, bodyPartType, handWeapon)
	
	if companionInInventory() and chance(5) 
			and ( checkIfNude(wornItems,false) or CheckIfNude(wornItems,true) )then -- jeżeli w ekwipunku jest laleczka i szansa wynosi 5 
		
		return NudeDialogue(wornItems,"Fight","ShirtlessFight","PantlessFight",1,1,1)

	elseif companionInInventory() and chance(SandboxVars.Companion.TalkOnZombieHit or 20) then
		if companionInSecondHand() then
			local weapCat = handWeapon:getCategories():get(0);
			if (weapCat=="Improvised" or weapCat=="SmallBlade"
					or weapCat=="Unarmed") and chance(80) then
				CommonDialog("Improvised",3);
			else 
				CommonDialog("Fight",4);
			end
		elseif companionInMainHand() then
			CommonDialog("Destroy",2); -- chuj
			changeToDoll(handWeapon);
		else 
			if handWeapon:isRanged() then
				if bodyPartType ~= Head then
					CommonDialog("Aiming",5);
				else 
					CommonDialog("Fight",4);
				end
			else
				if chance(5) then
					CommonDialog("Forgotten",3);
				end
			end
		end
	end
end
Events.OnHitZombie.Add(OnHitZombie)

local function EveryHours()
	canTalk = true;
end
Events.EveryHours.Add(EveryHours)

local function EveryTenMinutes() 
	updateThatPlayer();
	wornItems = thatPlayer:getWornItems();
	if canTalk then -- jak może mówić
		if chance(SandboxVars.Companion.TalkOnIdle or 5) and companionInInventory() then --jak chance zwróci true(x% albo 5%) i laleczka jest w ekwipunku
			if companionInHand() then --jak laleczka jest w którejs rece
				if chance(5) and not thatPlayer:isOutside() then --jak chance zwróci true(5%) i gracz jest w budynku
					CommonDialog("RandomInside",1) --dialog
				else 
					if CheckIfNude(wornItems,true) and CheckIfNude(wornItems,false) and chance(80) then
						NudeDialogue(wornItems,"Idle","NudeTakeOffShirt","IdlePantless",2,1,1)
					else
						CommonDialog("Random",6); --dialog
					end
				end
			else --jeżeli laleczka nie jest w ręku to znaczy że jest tylko w ekwipunku
				if  chance(15) then --5% szanWSsy na to że odjebie jedną z akcji
					RandomAche();
				else
					damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 50)
					CommonDialog("Forgotten",3);
				end
			end
		end
		-- jak zombiaki idą za tobą nawet jak laleczka nie może mówić ale jest w rękach.
	elseif (stats:getNumChasingZombies() > 0 or stats:getNumVisibleZombies() > 0) and companionInHand() then
		stats:setPanic(0);
		CommonDialog("BeBrave",1);
	else --laleczka nie może mówić i nie gonią zombiaki
		local var = SandboxVars.Companion.TalkSensitivity or 50;
		canTalk = ZombRand(100) <= var and true or false
	end
end
Events.EveryTenMinutes.Add(EveryTenMinutes)

function RandomAche()
	print("random ache");
	updateThatPlayer();
	local rand = ZombRand(100);
	if rand>90 then
		CommonDialog("Headache",1);
		damage:getBodyPart(BodyPartType.Head):setAdditionalPain(30);
	elseif rand>80 then
		print("hungry");
		CommonDialog("Hungry",2);
		local newhunger = stats:getHunger()+0.2;
		stats:setHunger(newhunger);
	elseif rand>40 then
		print("Sad");
		CommonDialog("Sadness",1);
		damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 50)
	elseif rand>=0 then
		print("Bored");
		CommonDialog("Bored",1);
		local newBored = damage:getBoredomLevel()+50;
		damage:setBoredomLevel(damage:getBoredomLevel() + 50)
		--stats:setBoredom(newBored);
	end
end

local function OnWeatherPeriodStage(weatherPeriod)
	print("piriod start");
	print(weatherPeriod);
end
Events.OnWeatherPeriodStage.Add(OnWeatherPeriodStage)

--local function EventWearClothing(wielder, character, handWeapon, damage)
--	print("EventWearClothing",wielder,character);
--end
--Events.EventWearClothing.Add(EventWearClothing)

local function onItemFall(item)
	if item:getName() == "Idnas" then
		updateThatPlayer();
		damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 30)
		CommonDialog("DropMe",3); -- upusciles mnie!
	elseif(companionInSecondHand()) and chance(SandboxVars.Companion.TalkOnDropItem or 80) then
		CommonDialog("Drop",2);
	end
end
Events.onItemFall.Add(onItemFall)

local function OnAIStateChange(character, newState, oldState)
	if(instanceof(character,"IsoPlayer")) then
		state = newState:getName();
		print(state);
		if companionInHand() and chance(20) then
			if state=="ClimbThroughWindowState" then
				if character:isOutside() then
					CommonDialog("ThroughWindowIn",2);
				else 
					CommonDialog("ThroughWindowOut",3);
				end
			elseif state=="OpenWindowState" then
				if character:isOutside() then
					CommonDialog("OpenWindowOut",3);
				else 
					CommonDialog("OpenWindowIn",1);
				end
			end
		end
	end
	-- przechodzenie przez płoty,  character:isClimbOverWallStruggle() character:isClimbOverWallSuccess()
	--siadanie
	--wstawanie
end
Events.OnAIStateChange.Add(OnAIStateChange)

local function OnAddMessage(chatMessage, tabId)
	if(companionInSecondHand()) and canTalk and chatMessage:getAuthor()==thatPlayer:getDisplayName() then
		CommonDialog("Talking",4);
	end
end
Events.OnAddMessage.Add(OnAddMessage)

local function OnPlayerGetDamage(player, damageType, damage)
	--getBodyDamage();
	if(companionInSecondHand()) and chance(SandboxVars.Companion.TalkOnGetDamage or 50) and damageType == "BLEEDING" then
		CommonDialog("Bleeding",3);
	end
end
Events.OnPlayerGetDamage.Add(OnPlayerGetDamage)

------------------------------------------------
-----------Override vanilla functions-----------
------------------------------------------------
inventoryTransfer = ISInventoryTransferAction.start
dropWorldItem = ISDropWorldItemAction.start
applyBandage = ISApplyBandage.start
unequipItemsAction = ISUnequipAction.perform
--local inventoryTransfer = ISInventoryTransferAction.start
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
					CommonDialog("ThrowAway",4);
				elseif chance(SandboxVars.Companion.TalkOnThrowItem or 5) and companionInSecondHand() then 
					CommonDialog("ThrowRandom",2);
				end
			end
		end
	end
end

--local dropWorldItem = ISDropWorldItemAction.start
function ISDropWorldItemAction:start()    
    dropWorldItem(self)  
	if companionInInventory() and self.item:getName() == "Idnas" then
		damage = thatPlayer:getBodyDamage();
		damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 30)
		CommonDialog("PutAway",3);
		--print(self.item);
	end
	--doSomething(self.item, self.character)
end

--local applyBandage = ISApplyBandage.start
function ISApplyBandage:start()
	applyBandage(self)
	if companionInSecondHand() and self.character == self.otherPlayer and chance(SandboxVars.Companion.TalkOnBandages or 50) and self.doIt then
		CommonDialog("Bandages",2);
	end
end

function ISUnequipAction:perform()
	unequipItemsAction(self)
	unequipedItem = self.item:getBodyLocation();
	if companionInHand() and (tableContains(upperLocations, unequipedItem) 
			or tableContains(lowerLocations, unequipedItem) ) then
		return NudeDialogue(self.character:getWornItems() ,"TakeOff","TakeOffShirt","TakeOffPants",1,1,2)
	end
end
------------------------------------------------
------------------Dialogues---------------------
------------------------------------------------

function CommonDialog(line,num)
	canTalk = false;
	if line and num then
		rand = ZombRand(num)+1;
		thatPlayer:setSpeakColour(idnasColor);
		thatPlayer:Say(getText("GameSound_"..line..rand));
		audio = emitter:playSound(line..rand);
		--sadness reduction
		updateThatPlayer();
		damage:setUnhappynessLevel(damage:getUnhappynessLevel() - 10)

		thatPlayer:setSpeakColour(playerColor);
	else 
		print("Line or num is nil");
	end
end

function AskForAdvice(items, result, player)
	--print(emitter:isPlaying(audio),"emitteret");
	--updatePosition = true;
	CommonDialog("Advice",8);
	print("hungerMultiplier",thatPlayer:getHungerMultiplier());
	print("lasthoursleped",thatPlayer:getLastHourSleeped());
	--Events.OnPlayerUpdate.Add(PI_AzaMusic_Update)
end

function Welcome(items, result, player)
	CommonDialog("Welcome",1);
end

function CheckIfNude(wornItems, upperBody)
	for key, value in ipairs(upperBody and upperLocations or lowerLocations) do
		if wornItems:getItem(value) then
			return false
		end
	end
	return true
end

function NudeDialogue(worn,l1,l2,l3,n1,n2,n3)
	if CheckIfNude(worn,true) and CheckIfNude(worn,false) then
		CommonDialog("Nude"..l1,n1); 
	elseif CheckIfNude(worn,true) then
		CommonDialog("Nude"..l2,n2);
	else 
		CommonDialog("Nude"..l3,n3);
	end
end

---debug---
local function OnKeyPressed(key)
	--print(debugValue);
	if debugValue then
		if key==34 then
			--RandomAche();
			print(thatPlayer:getCurrentActionContextStateName());
		end
	end
end
Events.OnKeyPressed.Add(OnKeyPressed)