
local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionHook", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end

local lib = _G[LIB_IDENTIFIER]
------------------------------------------------
-- Russian localization
------------------------------------------------
local localization = lib.localization
localization['es'] = {
	-- From game actionFilters
	[1] = "Buscar",			-- search
	[2] = "Hablar",			-- talk
	[3] = "Recolectar",		-- harvest
	[4] = "Desarmar",		-- disarm
	[5] = "Usar",			-- use
	[6] = "Leer",			-- read
	[7] = "Guardar",		-- take
	[8] = "Destruir",		-- destroy
	[9] = "Reparación",		-- repair
	[10] = "Inspeccionar",	-- inspect
	[11] = "Reparación",	-- repair
	[12] = "Abrir",			-- unlock
	[13] = "Abrir",			-- Open
	[14] = "",
	[15] = "Examinar",		-- Examine
	[16] = "Pescar",		-- Fish
	[17] = "Recoger sedal",	-- Reel In
	[18] = "Guardar",		-- Pack Up
	[19] = "Robar",			-- Steal
	[20] = "Robar",			-- Steal From
	[21] = "Robar",			-- Pickpocket
	[22] = "",
	[23] = "Allanar",		-- Trespass
	[24] = "Ocultarse",		-- Hide
	[25] = "Vista previa",	-- Preview
	[26] = "Salir",			-- Exit Home
	[27] = "Excavar",		-- Excavate

	-- From in game actions
	[28] = 'Mine',		-- mine
	[29] = 'Cut',		-- Cut
	[30] = 'Collect',		-- Collect
	[31] = 'Capture',	-- Capture
}
lib.localization = localization