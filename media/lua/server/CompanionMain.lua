function initialize(playerIndex, player)
	thatPlayer = player;
	stats = thatPlayer:getStats();
	damage = thatPlayer:getBodyDamage();
	wornItems = thatPlayer:getWornItems();
	bittenParts = 0;
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

local CompanionMain = { }

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
	--stats = thatPlayer:getStats();
	--damage = thatPlayer:getBodyDamage();
	--11bittenParts = damage:getNumPartsBitten();
end

function changeToDoll(remIdnas)
	thatPlayer:getInventory():AddItem("Doll");
	thatPlayer:setPrimaryHandItem(nil);
	thatPlayer:getInventory():Remove(remIdnas);
	--updateThatPlayer();
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

function CheckIfNude(wornItems, upperBody)
	for key, value in ipairs(upperBody and upperLocations or lowerLocations) do
		if wornItems:getItem(value) then
			return false
		end
	end
	return true
end

function RandomAche()
	print("random ache");
	--updateThatPlayer();
	local rand = ZombRand(100);
	if rand>90 then
		commonDialog("Headache",3);
		damage:getBodyPart(BodyPartType.Head):setAdditionalPain(30);
	elseif rand>80 then
		commonDialog("Hungry",3);
		stats:setHunger(stats:getHunger()+0.2);
	elseif rand>40 then
		commonDialog("Sadness",2);
		damage:setUnhappynessLevel(damage:getUnhappynessLevel() + 25)
	elseif rand>=0 then
		commonDialog("Bored",3);
		damage:setBoredomLevel(damage:getBoredomLevel() + 50)
	end
end

----------------------------------------------
--------------------DIALOGS-------------------

function commonDialog(line,num)
	canTalk = false;
	if line and num then
		rand = ZombRand(num)+1;
		thatPlayer:setSpeakColour(idnasColor);
		thatPlayer:Say(getText("GameSound_"..line..rand));
		audio = emitter:playSound(line..rand);
		--sadness reduction
		--updateThatPlayer();
		damage:setUnhappynessLevel(damage:getUnhappynessLevel() - 10)

		thatPlayer:setSpeakColour(playerColor);
		return true;
	else 
		print("Line or num is nil");
		return false;
	end
end

function AskForAdvice(items, result, player)
	--print(emitter:isPlaying(audio),"emitteret");
	--updatePosition = true;
	commonDialog("Advice",8);
	print("hungerMultiplier",thatPlayer:getHungerMultiplier());
	print("lasthoursleped",thatPlayer:getLastHourSleeped());
	--Events.OnPlayerUpdate.Add(PI_AzaMusic_Update)
end

function Welcome(items, result, player)
	commonDialog("Welcome",3);
end

function NudeDialogue(worn,l1,l2,l3,n1,n2,n3)
	if CheckIfNude(worn,true) and CheckIfNude(worn,false) and chance(80) then
		commonDialog("Nude"..l1,n1); 
	elseif CheckIfNude(worn,true) then
		commonDialog("Nude"..l2,n2);
	else 
		commonDialog("Nude"..l3,n3);
	end
end

function MoodleDialogue()
	if thatPlayer:getMoodleLevel(MoodleType.Panic) >1 and chance(80) and not thatPlayer:isSitOnGround() then
		commonDialog("CalmDown",2);
	elseif thatPlayer:getMoodleLevel(MoodleType.Hungry) >1 and chance(25) then
		commonDialog("Starving",2);
	elseif thatPlayer:getMoodleLevel(MoodleType.Thirst) >1 and chance(25) then
		commonDialog("Dehydration",2);
	elseif thatPlayer:getMoodleLevel(MoodleType.Sick) >1 and chance(50) then
		commonDialog("Sick",3);
	elseif thatPlayer:getMoodleLevel(MoodleType.HasACold) >1 and chance(50) then
		commonDialog("Bored",3);
	elseif thatPlayer:getMoodleLevel(MoodleType.Tired) >0 and chance(50) then
		commonDialog("Sleepy",2);
	else 
		return false;
	end
	return true
end

function ScareDialogue()
	stats:setPanic(1);
	commonDialog("Startle",3);​
end

---debug---
local function OnKeyPressed(key)
	if key==Keyboard.KEY_NUMPAD0  then
		print("num 0");
		canTalk=true;
	end
end
Events.OnKeyPressed.Add(OnKeyPressed)

--Events--

local function OnAddMessage(chatMessage, tabId)
	if(companionInSecondHand()) and canTalk and chatMessage:getAuthor()==thatPlayer:getDisplayName() then
		commonDialog("Talking",4);
	end
end
Events.OnAddMessage.Add(OnAddMessage)


return CompanionMain