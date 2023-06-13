------------------------------------------------
-- English localization
------------------------------------------------

local strings = {
	SI_LIB_IF_GAMECAMERAACTIONTYPE28 = 'Mine',
	SI_LIB_IF_GAMECAMERAACTIONTYPE29 = 'Cut',
	SI_LIB_IF_GAMECAMERAACTIONTYPE30 = 'Collect',
	SI_LIB_IF_GAMECAMERAACTIONTYPE31 = 'Capture',
}

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end

--[[
	LIB_IF_ACTIONTYPE_SEARCH		= 1		-- Search - loot
	LIB_IF_ACTIONTYPE_TALK			= 2		-- Talk
	LIB_IF_ACTIONTYPE_HARVEST		= 3		-- Harvest (Mine, Cut, Collect)
	LIB_IF_ACTIONTYPE_DISARM		= 4		-- Disarm
	LIB_IF_ACTIONTYPE_USE			= 5		-- Use
	LIB_IF_ACTIONTYPE_READ			= 6		-- Read
	LIB_IF_ACTIONTYPE_TAKE			= 7		-- Take
	LIB_IF_ACTIONTYPE_DESTROY		= 8		-- Destroy
	LIB_IF_ACTIONTYPE_REPAIR		= 9		-- Repair
	LIB_IF_ACTIONTYPE_INSPECT		= 10	-- Inspect
	LIB_IF_ACTIONTYPE_REPAIR2		= 11	-- Repair
	LIB_IF_ACTIONTYPE_UNLOCK		= 12	-- Unlock
	LIB_IF_ACTIONTYPE_OPEN			= 13	-- Open
	-- LIB_IF_ACTIONTYPE_			= 14	-- SI_GAMECAMERAACTIONTYPE14 is nil
	LIB_IF_ACTIONTYPE_EXAMINE		= 15	-- Examine
	LIB_IF_ACTIONTYPE_FISH			= 16	-- Fish
	LIB_IF_ACTIONTYPE_EXCAVATE		= 17	-- Excavate
	LIB_IF_ACTIONTYPE_PACKUP		= 18	-- Pack Up
	LIB_IF_ACTIONTYPE_STEAL			= 19	-- Steal
	LIB_IF_ACTIONTYPE_STEALFROM		= 20	-- Steal from
	LIB_IF_ACTIONTYPE_PICKPOCKET	= 21	-- Pickpocket
	--LIB_IF_ACTIONTYPE_			= 22	-- SI_GAMECAMERAACTIONTYPE22 is nil
	LIB_IF_ACTIONTYPE_TRESPASS		= 23	-- Trespass
	LIB_IF_ACTIONTYPE_HIDE			= 24	-- Hide
	LIB_IF_ACTIONTYPE_PREVIEW		= 25	-- Preview
	LIB_IF_ACTIONTYPE_EXIT			= 26	-- Exit
	LIB_IF_ACTIONTYPE_EXCAVATE		= 27	-- Excavate
	LIB_IF_ACTIONTYPE_MINE			= 28	-- Mine
	LIB_IF_ACTIONTYPE_CUT			= 29	-- Cut
	LIB_IF_ACTIONTYPE_COLLECT		= 30	-- Collect
	LIB_IF_ACTIONTYPE_COLLECT		= 31	-- Capture
	
	/script SetCVar("language.2", "en")
--]]
