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
		MyRaidClasses = {Mage=0, Shaman=0, Rogue=0, Druid=0, Warlock=0, Hunter=0, Warrior=0, Priest=0, Paladin=0} -- Set to 0 after test
		--MyRaidClasses = {Mage=1, Shaman=1, Rogue=1, Druid=1, Warlock=1, Hunter=1, Warrior=1, Priest=1, Paladin=6} -- Set to 0 after test
		MyMissingBuffs = {Mage={0}, Priest={0}, Druid={0}, Paladin1={0}, Paladin2={0}, Paladin3={0}, Paladin4={0}, Paladin5={0}, Paladin6={0}}
		BuffCheck = UnitName("player")

	end
end

function RaukinMissBuffs.READY_CHECK(self,event,arg1)
	-- Function to post missing buffs on readycheck here.
end

function RaukinMissBuffs.PLAYER_ENTERING_WORLD(self,event,arg1)
	MyClassTal = TalentCheck()
	MyRaidClasses = CheckClassRaid()
	MyMissingBuffs = MissingBuffCheck(MyRaidClasses, MyClassTal)
	MyCurrentBuffs = CheckCurrentBuffs()
	CheckTheBuffs()
end

function RaukinMissBuffs.PARTY_MEMBERS_CHANGED(self,event,arg1)
	MyRaidClasses = CheckClassRaid()
	MyMissingBuffs = MissingBuffCheck(MyRaidClasses, MyClassTal)
	MyCurrentBuffs = CheckCurrentBuffs()
	CheckTheBuffs()

end

function RaukinMissBuffs.PLAYER_AURAS_CHANGED(self,event,arg1)
	-- Call CheckBuffsAndSpec etc
	MyCurrentBuffs = CheckCurrentBuffs()
	CheckTheBuffs()

end

function CheckTheBuffs()
	local FoundMageBuff = 0
	local FoundPriestBuff = 0
	local FoundDruidBuff = 0
	local FoundPaladin1Buff = 0
	local FoundPaladin2Buff = 0
	local FoundPaladin3Buff = 0
	local FoundPaladin4Buff = 0
	local FoundPaladin5Buff = 0
	local FoundPaladin6Buff = 0

	for i=1,table.getn(MyCurrentBuffs) do
		if MyRaidClasses.Mage>=1 then
			FoundMageBuff = 2
			table1 = unpack(MyMissingBuffs.Mage)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundMageBuff = 1
					end
				end
			end
		end

		if MyRaidClasses.Priest>=1 then
			FoundPriestBuff = 2
			table1 = unpack(MyMissingBuffs.Priest)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundPriestBuff = 1
					end
				end
			end
		end
		if MyRaidClasses.Druid>=1 then
			FoundDruidBuff = 2
			table1 = unpack(MyMissingBuffs.Druid)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundDruidBuff = 1
					end
				end
			end
		end

		if MyRaidClasses.Paladin>=1 then
			FoundPaladin1Buff = 2
			table1 = unpack(MyMissingBuffs.Paladin1)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundPaladin1Buff = 1
					end
				end
			end
		end

		if MyRaidClasses.Paladin>=2 then
			FoundPaladin2Buff = 2
			table1 = unpack(MyMissingBuffs.Paladin2)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundPaladin2Buff = 1
					end
				end
			end
		end

		if MyRaidClasses.Paladin>=3 then
			FoundPaladin3Buff = 2
			table1 = unpack(MyMissingBuffs.Paladin3)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundPaladin3Buff = 1
					end
				end
			end
		end

		if MyRaidClasses.Paladin>=4 then
			FoundPaladin4Buff = 2
			table1 = unpack(MyMissingBuffs.Paladin4)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundPaladin4Buff = 1
					end
				end
			end
		end

		if MyRaidClasses.Paladin>=5 then
			FoundPaladin5Buff = 2
			table1 = unpack(MyMissingBuffs.Paladin5)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundPaladin5Buff = 1
					end
				end
			end
		end

		if MyRaidClasses.Paladin>=6 then
			FoundPaladin6Buff = 2
			table1 = unpack(MyMissingBuffs.Paladin6)
			if table1~=0 then
				for j=1,table.getn(table1) do
					buffname = GetSpellInfo(table1[j])
					if buffname==MyCurrentBuffs[i] then
						FoundPaladin6Buff = 1
					end
				end
			end
		end
	end

	if FoundMageBuff == 2 then
		-- Create Frame
	end

	if FoundPriestBuff == 2 then
		-- Create Frame
		print("Have priest no buff")
	end

	if FoundDruidBuff == 2 then
		-- Create Frame
		print("Have druid no buff")
	end

	if FoundPaladin1Buff == 2 then
		-- Create Frame
	end

	if FoundPaladin2Buff == 2 then
		-- Create Frame
	end

	if FoundPaladin3Buff == 2 then
		-- Create Frame
	end

	if FoundPaladin4Buff == 2 then
		-- Create Frame
	end

	if FoundPaladin5Buff == 2 then
		-- Create Frame
	end

	if FoundPaladin6Buff == 2 then
		-- Create Frame
	end
end

function CheckCurrentBuffs()
	local theCurrentBuffList = {}
	for i=1,40 do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitBuff("player", i)
		if name~=nil then
			table.insert(theCurrentBuffList,name)
		end
	end
	return theCurrentBuffList
end

function MissingBuffCheck(theRaidClasses, ownClass) 
	theMissingList = {Mage={}, Priest={}, Druid={}, Paladin1={}, Paladin2={}, Paladin3={}, Paladin4={}, Paladin5={}, Paladin6={}}

	----------------- Mage bufffs -----------------
	if theRaidClasses.Mage>0 then
		if ownClass~="WARRIORArms" and ownClass~="WARRIORFury" and ownClass~="WARRIORProtection" and ownClass~="DRUIDFeral" and ownClass~="ROGUEAssassination" and ownClass~="ROGUECombat" and ownClass~="ROGUESubtlety" then
			-- Arcane Intellect/Brilliance
			table.insert(theMissingList.Mage,{23028, 27127, 27126, 39235, 36880})
		else
			table.insert(theMissingList.Mage,{0})
		end
	end
	table.insert(theMissingList.Mage,{0})

	----------------- Priest bufffs -----------------
	if theRaidClasses.Priest>0 then
		-- Fortitude 
		table.insert(theMissingList.Priest,{21562, 39231, 21564, 25392, 36004, 25389, 23948, 23947})
	end
	table.insert(theMissingList.Priest,{0})

	----------------- Druid bufffs -----------------
	if theRaidClasses.Druid>0 then
		-- Mark of the Wild
		table.insert(theMissingList.Druid,{21850, 21849, 26991, 9884, 16878, 1126, 6756, 9885, 26990, 8907, 5232, 24752, 5234, 39233})
	end
	table.insert(theMissingList.Druid,{0})

	----------------- Paladin bufffs -----------------
	if ownClass=="WARRIORProtection" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25898, 20217}) -- Kings
		end

		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end

		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end

		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end

		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{0}) -- None
		end

		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="WARRIORArms" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="WARRIORFury" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="WARLOCKAffliction" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="WARLOCKDemonology" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="WARLOCKDestruction" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="PRIESTHoly" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="PRIESTShadow" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="PRIESTDiscipline" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="PALADINProtection" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="PALADINHoly" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="PALADINRetribution" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end

	elseif ownClass=="SHAMANElemental" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="SHAMANEnhancement" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end

	elseif ownClass=="SHAMANRestoration" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="ROGUEAssassination" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="ROGUECombat" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="ROGUESubtlety" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end
			
	elseif ownClass=="DRUIDBalance" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="DRUIDFeral" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="DRUIDRestoration" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="HUNTERBeast Mastery" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end

	elseif ownClass=="HUNTERMarksmanship" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end

	elseif ownClass=="HUNTERSurvival" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25916, 19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381}) -- Might
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin3,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end

	elseif ownClass=="MAGEArcane" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="MAGEFire" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	elseif ownClass=="MAGEFrost" then
		if theRaidClasses.Paladin>=1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end
		if theRaidClasses.Paladin>=2 then
			table.insert(theMissingList.Paladin2,{25898, 20217}) -- Kings
		end
		if theRaidClasses.Paladin>=3 then
			table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end
		if theRaidClasses.Paladin>=4 then
			table.insert(theMissingList.Paladin4,{27145, 19977, 19978, 19979, 27144, 32770, 25890}) -- Light
		end
		if theRaidClasses.Paladin>=5 then
			table.insert(theMissingList.Paladin5,{27169, 27168, 20911, 20912, 20913, 20914, 25899}) -- Sanctuary
		end
		if theRaidClasses.Paladin>=6 then
			table.insert(theMissingList.Paladin6,{0}) -- None
		end

	else
	end

	table.insert(theMissingList.Paladin1,{0})
	table.insert(theMissingList.Paladin2,{0})
	table.insert(theMissingList.Paladin3,{0})
	table.insert(theMissingList.Paladin4,{0})
	table.insert(theMissingList.Paladin5,{0})
	table.insert(theMissingList.Paladin6,{0})

	return theMissingList

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