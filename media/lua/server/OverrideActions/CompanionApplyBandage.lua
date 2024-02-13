local companion = require("CompanionMain");
local applyBandage = ISApplyBandage.start
function ISApplyBandage:start()
	applyBandage(self)
	if companionInSecondHand() and self.character == self.otherPlayer and chance(SandboxVars.Companion.TalkOnBandages or 50) and self.doIt then
		commonDialog("Bandages",2);
	end
end