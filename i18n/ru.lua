------------------------------------------------
-- Russian localization
------------------------------------------------

local strings = {
	SI_LIB_IF_GAMECAMERAACTIONTYPE28 = 'Добыть',
	SI_LIB_IF_GAMECAMERAACTIONTYPE29 = 'Взять',
	SI_LIB_IF_GAMECAMERAACTIONTYPE30 = 'Рубить',
	SI_LIB_IF_GAMECAMERAACTIONTYPE31 = 'Захватывать',
}

for stringId, stringValue in pairs(strings) do
	SafeAddString(stringId, stringValue, 2)
--	SafeAddVersion(_G[stringId], 1)
end


--[[
	LIB_IF_ACTIONTYPE_SEARCH		= 1		-- Обыскать
	LIB_IF_ACTIONTYPE_TALK			= 2		-- Поговорить
	LIB_IF_ACTIONTYPE_HARVEST		= 3		-- Собрать
	LIB_IF_ACTIONTYPE_DISARM		= 4		-- Обезвредить
	LIB_IF_ACTIONTYPE_USE			= 5		-- Использовать
	LIB_IF_ACTIONTYPE_READ			= 6		-- Читать
	LIB_IF_ACTIONTYPE_TAKE			= 7		-- Взять
	LIB_IF_ACTIONTYPE_DESTROY		= 8		-- Уничтожить
	LIB_IF_ACTIONTYPE_REPAIR		= 9		-- Починить
	LIB_IF_ACTIONTYPE_INSPECT		= 10	-- Осмотреть
	LIB_IF_ACTIONTYPE_REPAIR2		= 11	-- Починить
	LIB_IF_ACTIONTYPE_UNLOCK		= 12	-- Открыть замок
	LIB_IF_ACTIONTYPE_OPEN			= 13	-- Открыть
	-- LIB_IF_ACTIONTYPE_			= 14	-- SI_GAMECAMERAACTIONTYPE14 is nil
	LIB_IF_ACTIONTYPE_EXAMINE		= 15	-- Изучить
	LIB_IF_ACTIONTYPE_FISH			= 16	-- Ловить рыбу
	LIB_IF_ACTIONTYPE_REELIN		= 17	-- Выудить
	LIB_IF_ACTIONTYPE_PACKUP		= 18	-- Убрать
	LIB_IF_ACTIONTYPE_STEAL			= 19	-- Украсть
	LIB_IF_ACTIONTYPE_STEALFROM		= 20	-- Обшарить
	LIB_IF_ACTIONTYPE_PICKPOCKET	= 21	-- Обокрасть
	--LIB_IF_ACTIONTYPE_			= 22	-- SI_GAMECAMERAACTIONTYPE22 is nil
	LIB_IF_ACTIONTYPE_TRESPASS		= 23	-- Проникнуть
	LIB_IF_ACTIONTYPE_HIDE			= 24	-- Спрятаться
	LIB_IF_ACTIONTYPE_PREVIEW		= 25	-- Предпросмотр
	LIB_IF_ACTIONTYPE_EXIT			= 26	-- Выйти
	LIB_IF_ACTIONTYPE_EXCAVATE		= 27	-- Копать
	
	LIB_IF_ACTIONTYPE_MINE			= 28	-- Добыть
	LIB_IF_ACTIONTYPE_CUT			= 29	-- Взять
	LIB_IF_ACTIONTYPE_COLLECT		= 30	-- Рубить
	LIB_IF_ACTIONTYPE_COLLECT		= 31	-- Захватывать
	
IJA_DIWM_ACTIONS_TABLE = {
	["Обыскать"]		= 1,
	["Поговорить"]		= 2,
	
	["Добыть"]			= 3,
	["Взять"]			= 3,
	["Рубить"]			= 3,
	
	["Обезвредить"]		= 4,
	["Использовать"]	= 5,
	["Читать"]			= 6,
	["Взять"]			= 7,
	["Открыть замок"]	= 12,
	["Открыть"]			= 13,
	["Изучить"]			= 15,
	["Ловить рыбу"]		= 16,
	["Украсть"]			= 19,
	["Обшарить"]		= 20,
	["Спрятаться"]		= 24,
	["Копать"]			= 27,
}

1 Обыскать			"search"
2 Поговорить		"talk"
3 Собрать			"harvest"
4 Обезвредить		"disarm"
5 Использовать		"use"
6 Читать			"read"
7 Взять				"take"
8 Уничтожить		"destroy"
9 Починить			"repair"
10 Осмотреть		"inspect"
11 Починить			"repair"
12 Открыть замок	"unlock"
13 Открыть			"Open"
14 
15 Изучить			"Examine"
16 Ловить рыбу		"Fish"
17 Выудить			"Reel In"
18 Убрать			"Pack Up"
19 Украсть			"Steal"
20 Обшарить			"Steal From"
21 Обокрасть		"Pickpocket"
22 
23 Проникнуть		"Trespass"
24 Спрятаться		"Hide"
25 Предпросмотр		"Preview"
26 Выйти			"Exit Home"
27 Копать			"Excavate"


/script SetCVar("language.2", "en")
/script SetCVar("language.2", "jp")
/script for i=1, 27 do d(i .. ' ' .. GetString("SI_GAMECAMERAACTIONTYPE", i)) end

--]]