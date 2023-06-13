------------------------------------------------
-- German localization
------------------------------------------------

local strings = {
	-- translation by Baertram
	SI_LIB_IF_GAMECAMERAACTIONTYPE28 = 'Abbauen',
	SI_LIB_IF_GAMECAMERAACTIONTYPE29 = 'Hacken',
	SI_LIB_IF_GAMECAMERAACTIONTYPE30 = 'Nehmen',
	SI_LIB_IF_GAMECAMERAACTIONTYPE31 = 'Einfangen',
}

for stringId, stringValue in pairs(strings) do
	SafeAddString(stringId, stringValue, 2)
--	SafeAddVersion(_G[stringId], 1)
end

--[[
	LIB_IF_ACTIONTYPE_SEARCH		= 1		-- Durchsuchen
	LIB_IF_ACTIONTYPE_TALK			= 2		-- Reden
	LIB_IF_ACTIONTYPE_HARVEST		= 3		-- Einsammeln
	LIB_IF_ACTIONTYPE_DISARM		= 4		-- Entschärfen
	LIB_IF_ACTIONTYPE_USE			= 5		-- Benutzen
	LIB_IF_ACTIONTYPE_READ			= 6		-- Lesen
	LIB_IF_ACTIONTYPE_TAKE			= 7		-- Nehmen
	LIB_IF_ACTIONTYPE_DESTROY		= 8		-- Zerstören
	LIB_IF_ACTIONTYPE_REPAIR		= 9		-- Reparieren
	LIB_IF_ACTIONTYPE_INSPECT		= 10	-- Entersuchen
	LIB_IF_ACTIONTYPE_REPAIR2		= 11	-- Reparieren
	LIB_IF_ACTIONTYPE_UNLOCK		= 12	-- Aufschlieben
	LIB_IF_ACTIONTYPE_OPEN			= 13	-- Öffnen
	-- LIB_IF_ACTIONTYPE_			= 14	-- SI_GAMECAMERAACTIONTYPE14 is nil
	LIB_IF_ACTIONTYPE_EXAMINE		= 15	-- Untersuchen
	LIB_IF_ACTIONTYPE_FISH			= 16	-- Fischen
	LIB_IF_ACTIONTYPE_REELIN		= 17	-- Einholen
	LIB_IF_ACTIONTYPE_PACKUP		= 18	-- Verpacken
	LIB_IF_ACTIONTYPE_STEAL			= 19	-- Stehlen
	LIB_IF_ACTIONTYPE_STEALFROM		= 20	-- Inhalt stehlen
	LIB_IF_ACTIONTYPE_PICKPOCKET	= 21	-- Bestehlen
	--LIB_IF_ACTIONTYPE_			= 22	-- SI_GAMECAMERAACTIONTYPE22 is nil
	LIB_IF_ACTIONTYPE_TRESPASS		= 23	-- Eindringen
	LIB_IF_ACTIONTYPE_HIDE			= 24	-- Verstecken
	LIB_IF_ACTIONTYPE_PREVIEW		= 25	-- Vorschau
	LIB_IF_ACTIONTYPE_EXIT			= 26	-- Verlassen
	LIB_IF_ACTIONTYPE_EXCAVATE		= 27	-- Ausgraben
	
	LIB_IF_ACTIONTYPE_MINE			= 28	-- Abbauen
	LIB_IF_ACTIONTYPE_CUT			= 29	-- Hacken
	LIB_IF_ACTIONTYPE_COLLECT		= 30	-- Nehmen
	LIB_IF_ACTIONTYPE_COLLECT		= 31	-- Einfangen
]]
--[[
1 Durchsuchen		"search"
2 Reden				"talk"
3 Einsammeln		"harvest"
	["Mine"]		= 3,
	["Collect"]		= 3,
4 Entschärfen		"disarm"
5 Benutzen			"use"
6 Lesen				"read"
7 Nehmen			"take"
8 Zerstören			"destroy"
9 Reparieren		"repair"
10 Entersuchen		"inspect"
11 Reparieren		"repair"
12 Aufschlieben		"unlock"
13 Öffnen			"Open"

15 Untersuchen		"Examine"
16 Fischen			"Fish"
17 Einholen			"Reel In"
18 Verpacken		"Pack Up"
19 Stehlen			"Steal"
20 Inhalt stehlen	"Steal From"
21 Bestehlen		"Pickpocket"

23 Eindringen		"Trespass"
24 Verstecken		"Hide"
25 Vorschau			"Preview"
26 Verlassen		"Exit Home"
27 Ausgraben		"Excavate"

mine - Abbauen - Rubedite
mine - Abbauen	- platinum
select bait - Fischen - fishing
fish - Fischen - fishing


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
GetCVar("Language.2"
--]]