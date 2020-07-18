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
		RaukinMissBuffsDB.ClassTal = {}
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="WARLOCK", Tal={"Affliction", "Demonology", "Destruction"}})
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="DRUID", Tal={"Balance", "Feral", "Restoration"}})
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="ROGUE", Tal={"Assassination", "Combat", "Subtlety"}})
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="SHAMAN", Tal={"Elemental", "Enhancement", "Restoration"}})
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="PRIEST", Tal={"Discipline", "Holy", "Shadow"}})
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="WARRIOR", Tal={"Arms", "Fury", "Protection"}})
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="MAGE", Tal={"Arcane", "Fire", "Frost"}})
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="PALADIN", Tal={"Holy", "Protection", "Retribution"}})
			table.insert(RaukinMissBuffsDB.ClassTal,{Class="HUNTER", Tal={"Beast Mastery", "Marksmanship", "Survival"}})

		RaukinMissBuffs.MakeOptions()

		BuffCheck = UnitName("player")

	end
end

function RaukinMissBuffs.READY_CHECK(self,event,arg1)
	-- Function to post missing buffs on readycheck here.
end

function RaukinMissBuffs.PLAYER_ENTERING_WORLD(self,event,arg1)
	MyClassTal = TalentCheck()
end

function RaukinMissBuffs.PARTY_MEMBERS_CHANGED(self,event,arg1)
	MyRaidClasses = CheckClassRaid()
	MyMissingBufffs = MissingBufffCheck(MyRaidClasses, MyClassTal)
end

function RaukinMissBuffs.PLAYER_AURAS_CHANGED(self,event,arg1)
	-- Call CheckBuffsAndSpec etc
end

function MissingBufffCheck(theRaidClasses, ownClass)
	theMissingList = {}

	----------------- Mage bufffs -----------------
	if theRaidClasses.Mage>0 then
		if ownClass~="WARRIORArms" or ownClass~="WARRIORFury" or ownClass~="WARRIORProtection" or ownClass~="DRUIDFeral" then
			table.insert(theMissingList,{23028, 27127, 27126, 39235, 36880})
		end
	end

	----------------- Priest bufffs -----------------
	if theRaidClasses.Mage>0 then
		table.insert(theMissingList,{23028, 27127, 27126})
	end

end

function CheckClassRaid()
	local ClassInRaid = {Mage=0, Shaman=0, Rogue=0, Druid=0, Warlock=0, Hunter=0, Warrior=0, Priest=0, Paladin=0}
	local NumParty = GetNumPartyMembers()
	local Classes = {}
	if UnitInRaid("player") then
		--RaidCheck
		local g = GetNumRaidMembers() 
		for i=1,g do
			local name, rank, subgroup = GetRaidRosterInfo(i)
			_, Class1 = UnitClass(name)
			if subgroup<=5 then
				table.insert(Classes, Class1)	
			end			
		end
	elseif NumParty > 0 then
		--PartyCheck
		_, Class1 = UnitClass("party1")
		if Class1~=nil then
			table.insert(Classes, Class1)
		end
		_, Class2 = UnitClass("party2")
		if Class2~=nil then
			table.insert(Classes, Class2)
		end
		_, Class3 = UnitClass("party3")
		if Class3~=nil then
			table.insert(Classes, Class3)
		end
		_, Class4 = UnitClass("party4")
		if Class4~=nil then
			table.insert(Classes, Class4)
		end
		_, Class5 = UnitClass("player")
		if Class5~=nil then
			table.insert(Classes, Class5)
		end	
	end
	for i=1,table.getn(Classes) do
		if(Classes[i]=="WARLOCK") then
			ClassInRaid.Warlock = ClassInRaid.Warlock + 1
		elseif(Classes[i]=="MAGE") then
			ClassInRaid.Mage = ClassInRaid.Mage + 1
		elseif(Classes[i]=="SHAMAN") then
			ClassInRaid.Shaman = ClassInRaid.Shaman + 1
		elseif(Classes[i]=="ROGUE") then
			ClassInRaid.Rogue = ClassInRaid.Rogue + 1
		elseif(Classes[i]=="DRUID") then
			ClassInRaid.Druid = ClassInRaid.Druid + 1
		elseif(Classes[i]=="HUNTER") then
			ClassInRaid.Hunter = ClassInRaid.Hunter + 1
		elseif(Classes[i]=="WARRIOR") then
			ClassInRaid.Warrior = ClassInRaid.Warrior + 1
		elseif(Classes[i]=="PRIEST") then
			ClassInRaid.Priest = ClassInRaid.Priest + 1
		elseif(Classes[i]=="PALADIN") then
			ClassInRaid.Paladin = ClassInRaid.Paladin + 1
		end
	end
	
	return ClassInRaid
end

function TalentCheck()
	local numTabs = GetNumTalentTabs();
	local TalTree1 = 0;
	local TalTree2 = 0;
	local TalTree3 = 0;
	local MainTalent;
	local j;
	local ClassTalStr = "nil";
	for t=1, numTabs do
    		local numTalents = GetNumTalents(t);
    		local counttal = 0;
    		for i=1, numTalents do
        		_,_,_,_, currRank = GetTalentInfo(t,i);
   			counttal = counttal + currRank
   		end
		if t==1 then
			TalTree1=counttal;
		elseif t==2 then
			TalTree2=counttal;
		else
			TalTree3=counttal;
		end	
	end
	local _,classplay = UnitClass("player")
	if (TalTree1>=TalTree2) and (TalTree1>=TalTree3) then
		MainTalent = 1
	elseif (TalTree2>=TalTree1) and (TalTree2>=TalTree3) then
		MainTalent = 2
	elseif (TalTree3>=TalTree1) and (TalTree3>=TalTree2) then
		MainTalent = 3
	else
	end
	--for i=1,table.getn(RaukinMissBuffsDB.ClassTal) do
		--print(i,RaukinMissBuffsDB.ClassTal[i].Class,RaukinMissBuffsDB.ClassTal[i].Tal)
	--end
	j = contains(RaukinMissBuffsDB.ClassTal,classplay)
	--print(RaukinMissBuffsDB.ClassTal[j].Class,RaukinMissBuffsDB.ClassTal[j].Tal[MainTalent])
	ClassTalStr = RaukinMissBuffsDB.ClassTal[j].Class .. RaukinMissBuffsDB.ClassTal[j].Tal[MainTalent]
	return ClassTalStr
end

function contains(data, search)
	if table.getn(data)>0 then
		for i=1,table.getn(data) do
			if(data[i].Class==search) then
				return i
			end
		end
	end
	return 100
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