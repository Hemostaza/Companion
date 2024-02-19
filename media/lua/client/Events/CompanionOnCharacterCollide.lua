local companion = require("CompanionMain");

local function OnCharacterCollide(player, character)
	if(instanceof(player,"IsoPlayer")) then
		if companionInHand() then
			--kolizja gracza z zombie
			if(instanceof(character,"IsoZombie")) and
            chance(SandboxVars.Companion.TalkOnZombieCollide or 20) then 
				commonDialog("Collision");
			else 
				--jeżeli kolizja między graczami
			end
		end
	end
end
Events.OnCharacterCollide.Add(OnCharacterCollide)