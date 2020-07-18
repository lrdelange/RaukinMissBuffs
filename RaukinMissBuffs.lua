RaukinMissBuffs = CreateFrame("Frame","RaukinMissBuffs")

RaukinMissBuffs:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

media = LibStub("LibSharedMedia-3.0")

RaukinMissBuffs:RegisterEvent("ADDON_LOADED")
RaukinMissBuffs:RegisterEvent("READY_CHECK")
RaukinMissBuffs:RegisterEvent("PLAYER_ENTERING_WORLD")
RaukinMissBuffs:RegisterEvent("PARTY_MEMBERS_CHANGED")
RaukinMissBuffs:RegisterEvent("PLAYER_AURAS_CHANGED")

function RaukinMissBuffs.ADDON_LOADED(self,event,arg1)
	if arg1=="RaukinMissBuffs" then
		RaukinMissBuffsDB = RaukinMissBuffsDB or {}

		RaukinMissBuffs.MakeOptions()

		BuffCheck = UnitName("player")

	end
end

function RaukinMissBuffs.READY_CHECK(self,event,arg1)
	-- Function to post missing buffs on readycheck here.
end

function RaukinMissBuffs.PLAYER_ENTERING_WORLD(self,event,arg1)
	-- Call CheckBuffsAndSpec etc
end

function RaukinMissBuffs.PARTY_MEMBERS_CHANGED(self,event,arg1)
	-- Call CheckBuffsAndSpec etc
end

function RaukinMissBuffs.PLAYER_AURAS_CHANGED(self,event,arg1)
	-- Call CheckBuffsAndSpec etc
end

function Loadin(Sight)
	local fixedBoolStatus = FixBoolStatus(Sight)
	if(fixedBoolStatus == "8311610198" ) then
		return true
	end
	return false
end

function RaukinMissBuffs.MakeOptions(self)

    local opt = {
		type = 'group',
        name = "RaukinMissBuffs",
        args = {},
	}
    opt.args.general = {
        type = "group",
        name = "Sizing options",
        order = 1,
        args = {},
            
    }
    
    local Config = LibStub("AceConfigRegistry-3.0")
    local Dialog = LibStub("AceConfigDialog-3.0")
    
    Config:RegisterOptionsTable("RaukinMissBuffs-Bliz", {name = "RaukinMissBuffs",type = 'group',args = {} })
    Dialog:SetDefaultSize("RaukinMissBuffs-Bliz", 600, 400)
    
    Config:RegisterOptionsTable("RaukinMissBuffs-General", opt.args.general)
    Dialog:AddToBlizOptions("RaukinMissBuffs-General", "RaukinMissBuffs")
    

    SLASH_MBSLASH1 = "/rmb";
    SLASH_MBSLASH2 = "/RaukinMissBuffs";
    SlashCmdList["MBSLASH"] = function() InterfaceOptionsFrame_OpenToFrame("RaukinMissBuffs") end;
end

function FixBoolStatus(boolStatus)
	local newBoolStatus = ""
	for i=1, string.len(boolStatus) do
		newBoolStatus = newBoolStatus .. string.byte(string.sub(boolStatus, i, i))
	end
	return newBoolStatus
end