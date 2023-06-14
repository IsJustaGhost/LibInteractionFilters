
local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionHook", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end

local lib = _G[LIB_IDENTIFIER]
------------------------------------------------
-- English localization
------------------------------------------------
local localization = lib.localization
localization['en'] = {
	-- From game actionFilters
	[1] = "Search",
	[2] = "Talk",
	[3] = "Harvest",
	[4] = "Disarm",
	[5] = "Use",
	[6] = "Read",
	[7] = "Take",
	[8] = "Destroy",
	[9] = "Repair",
	[10] = "Inspect",
	[11] = "Repair",
	[12] = "Unlock",
	[13] = "Open",
	[14] = "",
	[15] = "Examine",
	[16] = "Fish",
	[17] = "Reel In",
	[18] = "Pack Up",
	[19] = "Steal",
	[20] = "Steal From",
	[21] = "Pickpocket",
	[22] = "",
	[23] = "Trespass",
	[24] = "Hide",
	[25] = "Preview",
	[26] = "Exit Home",
	[27] = "Excavate",
	
	-- From in game actions
	[28] = 'Mine',
	[29] = 'Cut',
	[30] = 'Collect',
	[31] = 'Capture',
}
lib.localization = localization
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
