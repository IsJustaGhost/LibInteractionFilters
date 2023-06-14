
local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionHook", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end

local lib = _G[LIB_IDENTIFIER]
------------------------------------------------
-- German localization
------------------------------------------------
local localization = lib.localization
localization['de'] = {
	-- From game actionFilters
	[1] = "Durchsuchen",	-- search
	[2] = "Reden",		-- talk
	[3] = "Einsammeln",	-- harvest
	[4] = "Entschärfen",	-- disarm
	[5] = "Benutzen",	-- use
	[6] = "Lesen",		-- read
	[7] = "Nehmen",		-- take
	[8] = "Zerstören",	-- destroy
	[9] = "Reparieren",	-- repair
	[10] = "Entersuchen",-- inspect
	[11] = "Reparieren",	-- repair
	[12] = "Aufschlieben",-- unlock
	[13] = "Öffnen",		-- Open
	[14] = "",
	[15] = "Untersuchen",-- Examine
	[16] = "Fischen",	-- Fish
	[17] = "Einholen",	-- Reel In
	[18] = "Verpacken",	-- Pack Up
	[19] = "Stehlen",	-- Steal
	[20] = "Inhalt stehlen",-- Steal From
	[21] = "Bestehlen",	-- Pickpocket
	[22] = "",
	[23] = "Eindringen",	-- Trespass
	[24] = "Verstecken",	-- Hide
	[25] = "Vorschau",	-- Preview
	[26] = "Verlassen",	-- Exit Home
	[27] = "Ausgraben",	-- Excavate
	
	-- From in game actions
	[28] = 'Abbauen',		-- Mine
	[29] = 'Hacken',		-- Cut
	[30] = 'Nehmen',		-- Collect
	[31] = 'Einfangen',		-- Capture
}
lib.localization = localization
--[[

butterfly - Einfangen - capture
dragonfly - Nehmen - take
 
fabric plant - Nehmen
nirn root - Nehmen
alchemy plant - Nehmen
runestone - Nehmen
water - Nehmen

log - Hacken
psyjic protal - Erbeuten - loot

disarm - Entschärfen


/script SetCVar("language.2", "de")
/script for i=1, 40 do d(i .. ' ' .. GetString("SI_GAMECAMERAACTIONTYPE", i)) end
GetCVar("Language.2")
--]]