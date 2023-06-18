
local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionHook", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end

local lib = _G[LIB_IDENTIFIER]
------------------------------------------------
-- Russian localization
------------------------------------------------
local localization = lib.localization
localization['zh'] = {
	-- From game actionFilters
	[1] = "搜索",	-- search
	[2] = "交谈",		-- talk
	[3] = "收获",	-- harvest
	[4] = "拆除",	-- disarm
	[5] = "使用",	-- use
	[6] = "阅读",		-- read
	[7] = "拿",		-- take
	[8] = "摧毁",	-- destroy
	[9] = "修理",	-- repair
	[10] = "检查",-- inspect
	[11] = "修理",	-- repair
	[12] = "解锁",-- unlock
	[13] = "打开",		-- Open
	[14] = "",
	[15] = "查看",-- Examine
	[16] = "鱼",	-- Fish
	[17] = "卷线",	-- Reel In
	[18] = "打包",	-- Pack Up
	[19] = "偷取",	-- Steal
	[20] = "偷",-- Steal From
	[21] = "扒窃",	-- Pickpocket
	[22] = "",
	[23] = "闯入",	-- Trespass
	[24] = "隐藏",	-- Hide
	[25] = "预览",	-- Preview
	[26] = "退出",	-- Exit Home
	[27] = "挖掘",	-- Excavate
	
	-- From in game actions
	[28] = '开采',		-- Mine
	[29] = '砍伐',		-- Cut
	[30] = '收集',		-- Collect
	[31] = '捕获',		-- Capture -- from google
}
lib.localization = localization