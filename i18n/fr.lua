
local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionHook", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end

local lib = _G[LIB_IDENTIFIER]
------------------------------------------------
-- French localization
------------------------------------------------
local localization = lib.localization
localization['fr'] = {
	-- From game actionFilters
	[1] = "Fouiller",			-- search
	[2] = "Parler",				-- talk
	[3] = "Récolter",			-- harvest
	[4] = "Désarmer",			-- disarm
	[5] = "Utiliser",			-- use
	[6] = "Lire",				-- read
	[7] = "Prendre",				-- take
	[8] = "Détruire",			-- destroy
	[9] = "Réparer",				-- repair
	[10] = "Inspecter",			-- inspect
	[11] = "Réparer",			-- repair
	[12] = "Déverrouiller",		-- unlock
	[13] = "Ouvrir",				-- Open
	[14] = "",
	[15] = "Examiner",			-- Examine
	[16] = "Pêcher",				-- Fish
	[17] = "Ramener la ligne",	-- Reel In
	[18] = "Faire vos Paquetages",-- Pack Up
	[19] = "Voler",				-- Steal
	[20] = "Piller",				-- Steal From
	[21] = "Voler à la tire",	-- Pickpocket
	[22] = "",
	[23] = "Entrer par effraction",-- Trespass
	[24] = "Se cacher",			-- Hide
	[25] = "Aperçu",				-- Preview
	[26] = "Quitter",			-- Exit Home
	[27] = "Excaver",			-- Excavate

	-- From in game actions
	[28] = 'Extraire',				-- Mine
	[29] = 'Couper',				-- Cut
	[30] = 'Ramasser',				-- Collect
	[31] = 'Capture',				-- Capture
}
lib.localization = localization