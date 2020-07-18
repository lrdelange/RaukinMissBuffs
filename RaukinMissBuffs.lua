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
	MyMissingBuffs = MissingBuffCheck(MyRaidClasses, MyClassTal)
	print(unpack(unpack(MyMissingBuffs.Paladin1)))
end

function RaukinMissBuffs.PLAYER_AURAS_CHANGED(self,event,arg1)
	-- Call CheckBuffsAndSpec etc
end

function MissingBuffCheck(theRaidClasses, ownClass) 
	theMissingList = {Mage={}, Priest={}, Druid={}, Paladin1={}, Paladin2={}, Paladin3={}, Paladin4={}, Paladin5={}, Paladin6={}}

	----------------- Mage bufffs -----------------
	if theRaidClasses.Mage>0 then
		if ownClass~="WARRIORArms" or ownClass~="WARRIORFury" or ownClass~="WARRIORProtection" or ownClass~="DRUIDFeral" then
			-- Arcane Intellect/Brilliance
			table.insert(theMissingList.Mage,{23028, 27127, 27126, 39235, 36880})
		end
	end

	----------------- Priest bufffs -----------------
	if theRaidClasses.Priest>0 then
		-- Fortitude 
		table.insert(theMissingList.Priest,{21562, 39231, 21564, 25392, 36004, 25389, 23948, 23947})
	end

	----------------- Druid bufffs -----------------
	if theRaidClasses.Druid>0 then
		-- Mark of the Wild
		table.insert(theMissingList.Druid,{})
	end

	----------------- Paladin bufffs -----------------
	if ownClass=="WARRIORProtection" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{20217, 25898}) -- Kings
		end

		if theRaidClasses.Paladin==2 then
			table.insert(theMissingList.Paladin2,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		end

		if theRaidClasses.Paladin==3 then
			table.insert(theMissingList.Paladin3,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		end

		if theRaidClasses.Paladin==4 then
			table.insert(theMissingList.Paladin4,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary
		end

	elseif ownClass=="WARRIORArms" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="WARRIORFury" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="WARLOCKAffliction" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="WARLOCKDemonology" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="WARLOCKDestruction" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="PRIESTHoly" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{20217, 25898}) -- Kings
		end

		table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="PRIESTShadow" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="PRIESTDiscipline" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{20217, 25898}) -- Kings
		end

		table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="PALADINProtection" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{20217, 25898}) -- Kings
		end

		table.insert(theMissingList.Paladin2,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin3,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary
		table.insert(theMissingList.Paladin4,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin5,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom

	elseif ownClass=="PALADINHoly" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="PALADINRetribution" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin5,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin6,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="SHAMANElemental" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="SHAMANEnhancement" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin5,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin6,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="SHAMANRestoration" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="ROGUEAssassination" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="ROGUECombat" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="ROGUESubtlety" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="DRUIDBalance" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="DRUIDFeral" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{20217, 25898}) -- Kings
		end

		table.insert(theMissingList.Paladin2,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		table.insert(theMissingList.Paladin3,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin4,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary
		table.insert(theMissingList.Paladin5,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom

	elseif ownClass=="DRUIDRestoration" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{20217, 25898}) -- Kings
		end

		table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin3,{25895, 1038}) -- Salvation
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="HUNTERBeast Mastery" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		end

		table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{25895, 1038}) -- Salvation
		table.insert(theMissingList.Paladin5,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin6,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="HUNTERMarksmanship" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		end

		table.insert(theMissingList.Paladin2,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin3,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin4,{25895, 1038}) -- Salvation
		table.insert(theMissingList.Paladin5,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin6,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="HUNTERSurvival" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{19837, 19740, 27140, 25291, 19834, 19835, 19836, 19838, 25782, 27141, 33564, 29381, 25916}) -- Might
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{25895, 1038}) -- Salvation
		table.insert(theMissingList.Paladin5,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin6,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="MAGEArcane" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="MAGEFire" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	elseif ownClass=="MAGEFrost" then
		if theRaidClasses.Paladin==1 then
			table.insert(theMissingList.Paladin1,{25895, 1038}) -- Salvation
		end

		table.insert(theMissingList.Paladin2,{20217, 25898}) -- Kings
		table.insert(theMissingList.Paladin3,{25918, 27143, 25894, 25290, 19852, 19853, 19742, 27142, 19850, 19854}) -- Wisdom
		table.insert(theMissingList.Paladin4,{19977, 19978, 19979, 27144, 32770, 25890, 27145}) -- Light
		table.insert(theMissingList.Paladin5,{27168, 20911, 20912, 20913, 20914, 25899, 27169}) -- Sanctuary

	else
	end
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