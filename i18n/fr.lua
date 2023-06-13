------------------------------------------------
-- French localization
------------------------------------------------
-- Courtesy of fzr6n7
local strings = {
	SI_LIB_IF_GAMECAMERAACTIONTYPE28 = 'Extraire',
	SI_LIB_IF_GAMECAMERAACTIONTYPE29 = 'Couper',
	SI_LIB_IF_GAMECAMERAACTIONTYPE30 = 'Ramasser',
	SI_LIB_IF_GAMECAMERAACTIONTYPE31 = 'Capture',
}

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(_G[stringId], 1)
end


--[[
	LIB_IF_ACTIONTYPE_SEARCH		= 1		-- Fouiller
	LIB_IF_ACTIONTYPE_TALK			= 2		-- Parler
	LIB_IF_ACTIONTYPE_HARVEST		= 3		-- Récolter
	LIB_IF_ACTIONTYPE_DISARM		= 4		-- Désarmer
	LIB_IF_ACTIONTYPE_USE			= 5		-- Utiliser
	LIB_IF_ACTIONTYPE_READ			= 6		-- Lire
	LIB_IF_ACTIONTYPE_TAKE			= 7		-- Prendre
	LIB_IF_ACTIONTYPE_DESTROY		= 8		-- Détruire
	LIB_IF_ACTIONTYPE_REPAIR		= 9		-- Réparer
	LIB_IF_ACTIONTYPE_INSPECT		= 10	-- Inspecter
	LIB_IF_ACTIONTYPE_REPAIR2		= 11	-- Réparer
	LIB_IF_ACTIONTYPE_UNLOCK		= 12	-- Déverrouiller
	LIB_IF_ACTIONTYPE_OPEN			= 13	-- Ouvrir
	-- LIB_IF_ACTIONTYPE_			= 14	-- SI_GAMECAMERAACTIONTYPE14 is nil
	LIB_IF_ACTIONTYPE_EXAMINE		= 15	-- Examiner
	LIB_IF_ACTIONTYPE_FISH			= 16	-- Pêcher
	LIB_IF_ACTIONTYPE_REELIN		= 17	-- Ramener la ligne
	LIB_IF_ACTIONTYPE_PACKUP		= 18	-- Faire vos Paquetages
	LIB_IF_ACTIONTYPE_STEAL			= 19	-- Voler
	LIB_IF_ACTIONTYPE_STEALFROM		= 20	-- Piller
	LIB_IF_ACTIONTYPE_PICKPOCKET	= 21	-- Voler à la tire
	--LIB_IF_ACTIONTYPE_			= 22	-- SI_GAMECAMERAACTIONTYPE22 is nil
	LIB_IF_ACTIONTYPE_TRESPASS		= 23	-- Entrer par effraction
	LIB_IF_ACTIONTYPE_HIDE			= 24	-- Se cacher
	LIB_IF_ACTIONTYPE_PREVIEW		= 25	-- Aperçu
	LIB_IF_ACTIONTYPE_EXIT			= 26	-- Quitter
	LIB_IF_ACTIONTYPE_EXCAVATE		= 27	-- Excaver
	
	LIB_IF_ACTIONTYPE_MINE			= 28	-- Extraire
	LIB_IF_ACTIONTYPE_CUT			= 29	-- Couper
	LIB_IF_ACTIONTYPE_COLLECT		= 30	-- Ramasser
	LIB_IF_ACTIONTYPE_COLLECT		= 31	-- Capture
	
	


/script SetCVar("language.2", "fr")
/script for i=1, 40 do d(i .. ' ' .. GetString("SI_GAMECAMERAACTIONTYPE", i)) end

--]]