
local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionHook", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end

local lib = _G[LIB_IDENTIFIER]
------------------------------------------------
-- Russian localization
------------------------------------------------
local localization = lib.localization
localization['ru'] = {
	-- From game actionFilters
	[1] = "Обыскать",	-- search
	[2] = "Поговорить",	-- talk
	[3] = "Собрать",		-- harvest
	[4] = "Обезвредить",	-- disarm
	[5] = "Использовать",-- use
	[6] = "Читать",		-- read
	[7] = "Взять",		-- take
	[8] = "Уничтожить",	-- destroy
	[9] = "Починить",	-- repair
	[10] = "Осмотреть",	-- inspect
	[11] = "Починить",	-- repair
	[12] = "Открыть замок",-- unlock
	[13] = "Открыть",	-- Open
	[14] = "",
	[15] = "Изучить",	-- Examine
	[16] = "Ловить рыбу",-- Fish
	[17] = "Выудить",	-- Reel In
	[18] = "Убрать",		-- Pack Up
	[19] = "Украсть",	-- Steal
	[20] = "Обшарить",	-- Steal From
	[21] = "Обокрасть",	-- Pickpocket
	[22] = "",
	[23] = "Проникнуть",	-- Trespass
	[24] = "Спрятаться",	-- Hide
	[25] = "Предпросмотр",-- Preview
	[26] = "Выйти",		-- Exit Home
	[27] = "Копать",		-- Excavate
	
	-- From in game actions
	[28] = 'Добыть',		-- mine
	[29] = 'Взять',			-- Cut
	[30] = 'Рубить',		-- Collect
	[31] = 'Захватывать',	-- Capture
}
lib.localization = localization