--[[
	TODO:
	Look into making a way to be able to call localized strings

lib.GetLocalizedStringForAction(action, lang)
	local langTable = allTheActionStrings[action]
	return langTable[lang], langTable[GetCVar("Language.2")] -- format the strings


	LIB_IF_GAMECAMERAACTION_ANY ?
]]



local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionHook", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end
local lib = _G[LIB_IDENTIFIER]

local ANY_ACTION = 'Any Action'
local lib_actionTypes = {}
lib.actionTypes = lib_actionTypes
-----------------------------------------------------------------------------
-- Dynamically generate ActionIds and Localization
-----------------------------------------------------------------------------
local actionIds = {
	-- From game actionFilters
	'LIB_IF_GAMECAMERAACTION_SEARCH',		-- Search - loot
	'LIB_IF_GAMECAMERAACTION_TALK',			-- Talk
	'LIB_IF_GAMECAMERAACTION_HARVEST',		-- Harvest (Mine, Cut, Collect)
	'LIB_IF_GAMECAMERAACTION_DISARM',		-- Disarm
	'LIB_IF_GAMECAMERAACTION_USE',			-- Use
	'LIB_IF_GAMECAMERAACTION_READ',			-- Read
	'LIB_IF_GAMECAMERAACTION_TAKE',			-- Take
	'LIB_IF_GAMECAMERAACTION_DESTROY',		-- Destroy
	'LIB_IF_GAMECAMERAACTION_REPAIR',		-- Repair
	'LIB_IF_GAMECAMERAACTION_INSPECT',		-- Inspect
	'LIB_IF_GAMECAMERAACTION_REPAIR2',		-- Repair
	'LIB_IF_GAMECAMERAACTION_UNLOCK',		-- Unlock
	'LIB_IF_GAMECAMERAACTION_OPEN',			-- Open
	'',-- LIB_IF_GAMECAMERAACTION_			= 14	-- SI_GAMECAMERAACTIONTYPE14 is nil
	'LIB_IF_GAMECAMERAACTION_EXAMINE',		-- Examine
	'LIB_IF_GAMECAMERAACTION_FISH',			-- Fish
	'LIB_IF_GAMECAMERAACTION_REELIN',		-- Reel In
	'LIB_IF_GAMECAMERAACTION_PACKUP',		-- Pack Up
	'LIB_IF_GAMECAMERAACTION_STEAL',		-- Steal
	'LIB_IF_GAMECAMERAACTION_STEALFROM',	-- Steal from
	'LIB_IF_GAMECAMERAACTION_PICKPOCKET',	-- Pickpocket
	'',--LIB_IF_GAMECAMERAACTION_			= 22	-- SI_GAMECAMERAACTIONTYPE22 is nil
	'LIB_IF_GAMECAMERAACTION_TRESPASS',		-- Trespass
	'LIB_IF_GAMECAMERAACTION_HIDE',			-- Hide
	'LIB_IF_GAMECAMERAACTION_PREVIEW',		-- Preview
	'LIB_IF_GAMECAMERAACTION_EXIT',			-- Exit
	'LIB_IF_GAMECAMERAACTION_EXCAVATE',		-- Excavate
	
	-- From in game actions
	'LIB_IF_GAMECAMERAACTION_MINE',			-- Mine
	'LIB_IF_GAMECAMERAACTION_CUT',			-- Cut
	'LIB_IF_GAMECAMERAACTION_COLLECT',		-- Collect
	'LIB_IF_GAMECAMERAACTION_CAPTURE',		-- Capture
}

-- "Registring" the actionIds to global
for i, actionType in ipairs(actionIds) do
	if actionType ~= '' then
		_G[actionType] = i
	end
end

-- Register strings
local currentLang
do
	-- If currentLang is not in localization then default to en.
	local function getCurrentLang(lang)
		if not lib.localization[lang] then
			return getCurrentLang("en")
		end
		return lang
	end
	currentLang = getCurrentLang(GetCVar("Language.2"))

	local currentStrings = lib.localization[currentLang]

	for i, action in ipairs(currentStrings) do
		if action ~= '' then
			local stringId = 'SI_LIB_IF_GAMECAMERAACTION' .. i
			ZO_CreateStringId(stringId, action)
			SafeAddVersion(stringId, 1)
		end
	end
end

-- Generate action localization table
do
	local localizationStings = lib.localization
	-- Reporpus lib.localization for traslated actions table.
	lib.localization = {}
	for k, lang in pairs({"en", "de", "fr", "ru"}) do
		local actionTable = localizationStings[lang]
		for i, action in ipairs(actionTable) do
			if action ~= '' then
				local localizedAction = lib.localization[i] or {}
				localizedAction[lang] = action
				lib.localization[i] = localizedAction
			end
		end
	end
end

-----------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------
local lib_reticle = RETICLE

function lib.IterateSelectedAction(action)
	local actionTypes = lib_actionTypes[action] or {}
	local nextKey, nextData = next(actionTypes)
	return function()
		while nextKey do
			local registerdName, callback = nextKey, nextData
			nextKey, nextData = next(actionTypes, nextKey)
			
			if callback then
				return callback
			end
		end
	end
end

-- where ... = interactableName, currentFrameTimeSeconds
function lib.IsInteractionDisabled(action, ...)
	local isDisabled = false

	for k, _action in ipairs({action, ANY_ACTION}) do
		for callback in lib.IterateSelectedAction(_action) do
			if callback(action, ...) then
				isDisabled = true
			end
		end
	end

	return isDisabled
end

-- where ... = currentFrameTimeSeconds
function lib.OnTryHandelingInteraction(...)
	local action, interactableName = GetGameCameraInteractableActionInfo()

	lib.interactionDisabled = lib.IsInteractionDisabled(action, interactableName, ...)
	if lib.interactionDisabled then
		-- set the interaction as blocked, to gray out the keybind
		lib_reticle.interactionBlocked = lib.interactionDisabled
	end
end

function lib:HideInteraction(hidden)
	lib_reticle.interact:SetHidden(true)
end
-- lib_reticle:RequestHidden(true)
-- lib_reticle:RequestHidden(false)
-----------------------------------------------------------------------------
-- Un/Register
-----------------------------------------------------------------------------
function lib:RegisterOnTryHandlingInteraction(registerdName, action, callback)
	local action_type = type(action)
	if action_type == 'function' then
		callback = action
		action = ANY_ACTION
	elseif action_type == 'number' then
		action = GetString(action)
	end
	
	assert(type(registerdName) == 'string' and (callback ~= nil and type(callback) == 'function') and type(action) ~= nil , 
		string.format("LIB_INTERACTION_FILTERS.RegisterOnTryHandlingInteraction': Your parameters are wrong. Needed types are: ... / Your values are: addonName %q, action %q, filter: %s", tostring(registerdName), tostring(action), tostring(callback)))
	
	local actionType = lib_actionTypes[action] or {}
	lib_actionTypes[action] = actionType
	
	-- where ... = action, interactableName, currentFrameTimeSeconds
	actionType[registerdName] = function(...)
		return callback(...)
	end
end

function lib:UnregisterOnTryHandlingInteraction(registerdName, action)
	if type(action) == 'number' then
		action = GetString(action)
	else
		action = action or ANY_ACTION
	end
	
	local actionType = lib_actionTypes[action]
	if actionType ~= nil then
		actionType[registerdName] = nil
		
		if NonContiguousCount(lib_actionTypes[action]) == 0 then
			lib_actionTypes[action] = nil
		end
	end
end

-----------------------------------------------------------------------------
-- Get action info
-----------------------------------------------------------------------------
-- Post the list of actions and thier actionType to chat
function lib.ListAllActionsInfo()
	for i, actionType in ipairs(actionTypes) do
		if actionType ~= '' then
			d( zo_strformat('<<1>> = <<2>>, String = <<3>>', actionType, i, GetString('SI_LIB_IF_GAMECAMERAACTION', i)))
		end
	end
end

-- returns [table]actionsInfo
function lib.GetAllActionsInfo()
	local actionsInfo = {}
	for i, actionType in ipairs(actionTypes) do
		if actionType ~= '' then
			local newEntry = {
					actionType = i,
					constant = actionType,
					action = GetString('SI_LIB_IF_GAMECAMERAACTION', i)
				}
			table.insert(actionsInfo, newEntry)
		end
	end
	return actionsInfo
end

function lib:GetActionTranslation(actionId, toLang)
	local localizedAction = self.localization[actionId]
	if not localizedAction[toLang] then
		toLang = currentLang
	end
	return zo_strformat('[<<1>>] = <<2>> >> <<3>>', actionId, localizedAction[currentLang], localizedAction[toLang])
end

LIB_INTERACTION_HOOK = lib
--	/script d(LIB_INTERACTION_HOOK:GetActionTranslation(LIB_IF_GAMECAMERAACTION_UNLOCK, "de"))
-- "[12] = Unlock >> Aufschlieben"
--	/script LIB_INTERACTION_HOOK.ListAllActionsInfo()
--	/tb LIB_INTERACTION_HOOK.GetAllActionsInfo()
--	/tb LIB_INTERACTION_HOOK:GetAllActionsInfo()
-----------------------------------------------------------------------------
-- Hook
-----------------------------------------------------------------------------
-- RETICLE.interactionDisabled is added and used to prevent interaction at INTERACTIVE_WHEEL_MANAGER.StartInteraction()
-- Setting RETICLE.interactionBlocked to true will cause the reticle keybind to turn gray.
--SecurePostHook(lib_reticle, "TryHandlingInteraction", function(self, currentFrameTimeSeconds)

-- Changing it to use "UpdateInteractText" to make it so that hiding the 
-- interaction is possible with LIB_INTERACTION_HOOK:HideInteraction()
--[[
	
SecurePostHook(lib_reticle, "TryHandlingInteraction", function(self, interactionPossible, currentFrameTimeSeconds)
	if not interactionPossible then return end
	
	lib.OnTryHandelingInteraction( currentFrameTimeSeconds)
end)
]]
SecurePostHook(lib_reticle, "UpdateInteractText", function(self, currentFrameTimeSeconds)
    local interactionPossible = not self.interact:IsHidden()
	if IsPlayerGroundTargeting() then return end

	local interactionExists, _, questInteraction = GetGameCameraInteractableInfo()
	if interactionExists and not questInteraction then
		lib.OnTryHandelingInteraction(currentFrameTimeSeconds)
	end
end)

-- TryHandlingNonInteractableFixture
-- TryHandlingQuestInteraction
-----------------------------------------------------------------------------
-- Disabling interaction.
-----------------------------------------------------------------------------
-- This must be used in order to allow gamepad users to jump while interation is disabled
function lib_reticle:GetInteractPromptVisible()
	if lib.interactionDisabled then
		return false
	end
	return not self.interact:IsHidden()
end

-- This must return true in order to prevent interactions
-- Using a hook would return nil, which would allow the interaction to run.
-- if not INTERACTIVE_WHEEL_MANAGER:StartInteraction(ZO_INTERACTIVE_WHEEL_TYPE_FISHING) then GameCameraInteractStart() end
local orig_StartInteraction = INTERACTIVE_WHEEL_MANAGER.StartInteraction
function INTERACTIVE_WHEEL_MANAGER:StartInteraction(interactiveWheelType)
	-- Lets at least run the original so it can do it's thing before canceling it out to disable interactions.
	local result = orig_StartInteraction(self, interactiveWheelType)
	if interactiveWheelType == ZO_INTERACTIVE_WHEEL_TYPE_FISHING and lib.interactionDisabled then
		return true
	end
	return result
end
