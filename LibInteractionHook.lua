--[[
- - - 3.1
○ did some cleaning up
○ changed SetAdditionalInfoColor and added assert
○ added assert to SetInteractKeybindButtonColor
○ added lib.HideNonInteractable()
○ added assert to getCurrentLang
○ 

- - - 3
○ rewrote much of the library
○ now supports "en", "de", "fr", "ru", "es", "zh"
○ passed params are now (action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract, currentFrameTimeSeconds)
-- this is done so addons do not have to run GetGameCameraInteractableActionInfo to get the information
○ moved hook to UpdateInteractText so allow hiding the interaction through a function
-- otherwise, it was not possible to effectively hide the interaction through the lib
○ 
○ 

]]

local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionHook", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end
local lib = _G[LIB_IDENTIFIER]

local ANY_ACTION = 'Any Action'
local lib_actions = {}
lib.actions = lib_actions

-- Only used once but, I want it here so I can see them.
local languages = {"en", "de", "fr", "ru", "es", "zh"}

-----------------------------------------------------------------------------
-- Dynamically generate ActionIds and Localization
-----------------------------------------------------------------------------
local function safeAddString(stringId, stringValue, stringVersion)
	if type(stringId) ~= "number" then
		-- Attempt to get the stringId from the [string]stringId
		stringId = _G[stringId] or stringId
	end

	stringVersion = stringVersion or 1
	if type(stringId) == "number" then
		-- The stringId actually exsists so try to update it based on versions.
		SafeAddString(stringId, stringValue, stringVersion)
	else
		-- The stringId does not exist so create a new one.
		ZO_CreateStringId(stringId, stringValue)
    end
	SafeAddVersion(stringId, stringVersion)
end

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
			assert(false, 'LibInteractionHook: The current game language is not supported. Contact the author about adding support.')
			return getCurrentLang("en")
		end
		return lang
	end
	currentLang = getCurrentLang(GetCVar("Language.2"))

	local currentStrings = lib.localization[currentLang]

	for i, action in ipairs(currentStrings) do
		if action ~= '' then
			local stringId = 'SI_LIB_IF_GAMECAMERAACTION' .. i
			safeAddString(stringId, action, 1)
		end
	end
end

-- Generate action localization table
do
	local localizationStings = lib.localization
	-- Reporpus lib.localization for traslated actions table.
	lib.localization = {}
	for k, lang in pairs(languages) do
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
	local actionTypes = lib_actions[action] or {}
	local nextKey, nextData = next(actionTypes)
	return function()
		while nextKey do
			local callback = nextData
			nextKey, nextData = next(actionTypes, nextKey)
			
			if callback then
				return callback
			end
		end
	end
end

function lib.OnTryHandelingInteraction(currentFrameTimeSeconds)
	local action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract = GetGameCameraInteractableActionInfo()
	
	lib.interactionDisabled = false
	-- Only functions registered for the current target interaction action and those registered with no action will run.
	for k, _action in ipairs({action, ANY_ACTION}) do
		for callback in lib.IterateSelectedAction(_action) do
			-- If callback returns true then we know it wants to disable the interaction.
			-- However, we will allow other callbacks to run so the registered addon can at least get the information.
			if callback(action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract, currentFrameTimeSeconds) then
				-- If it turns out addons themselves can't find a way to deal with compatibility issues, may make this return true
				lib.interactionDisabled = true
			end
		end
	end

	return lib.interactionDisabled
end

-----------------------------------------------------------------------------
-- Interaction info manipualtion
-----------------------------------------------------------------------------
-- Example: interactKeybindButtonColor = ZO_SUCCEEDED_TEXT
function lib.SetInteractKeybindButtonColor(interactKeybindButtonColor)
	assert(type(interactKeybindButtonColor) == 'table' and interactKeybindButtonColor.UnpackRGBA , 'LibInteractionHook.SetAdditionalInfoColor: Color must be definded by ZO_ColorDef')
	
	lib_reticle.interactKeybindButton:SetNormalTextColor(interactKeybindButtonColor)
end

-- Example: additionalInfoColor = ZO_SUCCEEDED_TEXT
function lib.SetAdditionalInfoColor(additionalInfoColor)
	assert(type(additionalInfoColor) == 'table' and additionalInfoColor.UnpackRGBA , 'LibInteractionHook.SetAdditionalInfoColor: Color must be definded by ZO_ColorDef')
	
	lib_reticle.additionalInfo:SetColor(additionalInfoColor:UnpackRGBA())
end

function lib.HideInteraction()
	lib_reticle.interact:SetHidden(true)
end

function lib.HideNonInteractable()
	lib_reticle.nonInteract:SetHidden(true)
end

-----------------------------------------------------------------------------
-- Un/Register
-----------------------------------------------------------------------------
function lib.RegisterOnTryHandlingInteraction(registerdName, action, callback)
	local action_type = type(action)
	if action_type == 'function' then
		callback = action
		action = ANY_ACTION
	elseif action_type == 'number' then
		action = GetString(action)
	end
	
	assert(type(registerdName) == 'string' and (callback ~= nil and type(callback) == 'function') and type(action) ~= nil , 
		string.format("LibInteractionHook.RegisterOnTryHandlingInteraction': Your parameters are wrong. Needed types are: ... / Your values are: addonName %q, action %q, filter: %s", tostring(registerdName), tostring(action), tostring(callback)))
	
	local actionTable = lib_actions[action] or {}
	lib_actions[action] = actionTable
	
	-- where ... = action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract, currentFrameTimeSeconds
	actionTable[registerdName] = function(...)
		return callback(...)
	end
end

function lib.UnregisterOnTryHandlingInteraction(registerdName, action)
	if type(action) == 'number' then
		action = GetString(action)
	else
		action = action or ANY_ACTION
	end
	
	local actionTable = lib_actions[action]
	if actionTable ~= nil then
		actionTable[registerdName] = nil
		
		if NonContiguousCount(lib_actions[action]) == 0 then
			lib_actions[action] = nil
		end
	end
end

-----------------------------------------------------------------------------
-- Get action info
-----------------------------------------------------------------------------
-- Post the list of actions and thier actionType to chat
function lib.ListAllActionsInfo()
	for i, actionId in ipairs(actionIds) do
		if actionId ~= '' then
			d( zo_strformat('<<1>> = <<2>>, String = <<3>>', actionId, i, GetString('SI_LIB_IF_GAMECAMERAACTION', i)))
		end
	end
end

-- returns [table]actionsInfo
function lib.GetAllActionsInfo()
	local actionsInfo = {}
	for i, actionId in ipairs(actionIds) do
		if actionId ~= '' then
			local newEntry = {
					index = i,
					actionId = actionId,
					action = GetString('SI_LIB_IF_GAMECAMERAACTION', i)
				}
			table.insert(actionsInfo, newEntry)
		end
	end
	return actionsInfo
end

function lib.GetActionTranslation(actionId, toLang)
	local localizedAction = lib.localization[actionId]
	if not localizedAction[toLang] then
		toLang = currentLang
	end
	return zo_strformat('[<<1>>] = <<2>> >> <<3>>', actionId, localizedAction[currentLang], localizedAction[toLang])
end

--LIB_INTERACTION_HOOK = lib
--	/script d(LibInteractionHook:GetActionTranslation(LIB_IF_GAMECAMERAACTION_UNLOCK, "de"))
-- "[12] = Unlock >> Aufschlieben"
--	/script LibInteractionHook.ListAllActionsInfo()
--	/tb LibInteractionHook.GetAllActionsInfo()
-----------------------------------------------------------------------------
-- Hook
-----------------------------------------------------------------------------
-- lib.interactionDisabled is added and used to prevent interaction at INTERACTIVE_WHEEL_MANAGER.StartInteraction()
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
		-- Since this is now happening after the keybind button state was set, we'll do it here to change it if disabled.
		-- Setting it disabled only causes it to be faded. That's why other steps have been made to disable interaction.
		if lib.OnTryHandelingInteraction(currentFrameTimeSeconds) then
			self.interactKeybindButton:SetEnabled(false)
		end
	end
end)

-- TryHandlingNonInteractableFixture
-- TryHandlingQuestInteraction
-----------------------------------------------------------------------------
-- Disabling interaction.
-----------------------------------------------------------------------------
-- This must be used in order to allow gamepad users to jump while interation is disabled
-- It's the check used to see if they should jump or interact. 
function lib_reticle:GetInteractPromptVisible()
	if lib.interactionDisabled then
		return false
	end
	return not self.interact:IsHidden()
end
--[[ Original
function ZO_Reticle:GetInteractPromptVisible()
    return not self.interact:IsHidden()
end
]]
-- This must return true in order to prevent interactions in keyboard mode.
-- Using a hook would return nil, which would allow the interaction to run.
-- if not INTERACTIVE_WHEEL_MANAGER:StartInteraction(ZO_INTERACTIVE_WHEEL_TYPE_FISHING) then GameCameraInteractStart() end
local orig_StartInteraction = INTERACTIVE_WHEEL_MANAGER.StartInteraction
function INTERACTIVE_WHEEL_MANAGER:StartInteraction(interactiveWheelType)
	-- ZO_INTERACTIVE_WHEEL_TYPE_FISHING is used for GAME_CAMERA_INTERACT
	if interactiveWheelType == ZO_INTERACTIVE_WHEEL_TYPE_FISHING and lib.interactionDisabled then
		return true
	end
	return orig_StartInteraction(self, interactiveWheelType)
end

--[[EXAMPLES:
To register a function
local registerOnTryHandlingInteraction = LibInteractionHook.RegisterOnTryHandlingInteraction
To unregister a function
local unregisterOnTryHandlingInteraction = LibInteractionHook.UnregisterOnTryHandlingInteraction
To set the color of the additional info
local setAdditionalInfoColor = LibInteractionHook.SetAdditionalInfoColor
To set the color of the keybind button text color
local setInteractKeybindButtonColor = LibInteractionHook.SetInteractKeybindButtonColor
To hide interactions
local hideInteraction = LibInteractionHook.HideInteraction

The following examples are only used to disable interaction
---------------------------------------------------------------
local actionsTable = {
	-- Can use the strings or stringId
	[SI_LIB_IF_GAMECAMERAACTION1]	= true,
	[SI_LIB_IF_GAMECAMERAACTION2]	= true,
	[SI_LIB_IF_GAMECAMERAACTION3]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 4)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 5)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 6)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 7)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 12)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 13)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 15)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 16)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 19)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 20)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 24)]	= true,
	[GetString("SI_LIB_IF_GAMECAMERAACTION", 27)]	= true,
}

for actionName, i in pairs(actionsTable) do
	registerOnTryHandlingInteraction(self.name, actionName, function(action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract, currentFrameTimeSeconds)
		-- There is no need to check for if interactionIsPossibel, this will only run if it is.

		-- Is this filer enabled?
		if disabledInteractions(action, interactableName) then
			-- Should this action be disabled?
			if isActionDisabled(action, interactableName, currentFrameTimeSeconds) then
				return true
			end
		end
		return false
	end)

---------------------------------------------------------------
	actionName = GetString(SI_LIB_IF_GAMECAMERAACTION1) or SI_LIB_IF_GAMECAMERAACTION1 or "Search"

	registerOnTryHandlingInteraction(self.name, actionName, function(action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract, currentFrameTimeSeconds)
		-- There is no need to check for if interactionIsPossibel, this will only run if it is.

		-- Is this filer enabled?
		if disabledInteractions(action, interactableName) then
			-- Should this action be disabled?
			if isActionDisabled(action, interactableName, currentFrameTimeSeconds) then
				return true
			end
		end
		return false
	end)
	
---------------------------------------------------------------
	Here actionName is ommited to register for any action

	registerOnTryHandlingInteraction(self.name, function(action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract, currentFrameTimeSeconds)
		-- There is no need to check for if interactionIsPossibel, this will only run if it is.

		-- Is this filer enabled?
		if disabledInteractions(action, interactableName) then
			-- Should this action be disabled?
			if isActionDisabled(action, interactableName, currentFrameTimeSeconds) then
				hideInteraction()
				return true
			end
		end
		return false
	end)

	This example will hide the interaction
---------------------------------------------------------------
	registerOnTryHandlingInteraction(self.name, function(action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract, currentFrameTimeSeconds)
		-- There is no need to check for if interactionIsPossibel, this will only run if it is.

		-- Is this filer enabled?
		if disabledInteractions(action, interactableName) then
			-- Should this action be disabled?
			if isActionDisabled(action, interactableName, currentFrameTimeSeconds) then
				hideInteraction()
				return true
			end
		end
		return false
	end)


	This example modifies the interaction text using additional functions to get the specific information changes needed for this addon.
---------------------------------------------------------------
	registerOnTryHandlingInteraction(self.name, function(action, interactableName, interactionBlocked, isOwned, additionalInteractInfo, context, contextLink, isCriminalInteract, currentFrameTimeSeconds)
		if action and interactableName then
			if self.savedVars.eventActive and self:IsTargetForTickets(interactableName) then
				local additionalInfoText, interactKeybindButtonText, interactionBlocked, interactKeybindButtonColor, additionalInfoLabelColor = getInterationInfo(action, interactableName)
				
				RETICLE.interactKeybindButton:ShowKeyIcon()
				RETICLE.interact:SetHidden(false)
				
				RETICLE.interactContext:SetText(interactableName) -- "Jubilee Cake" .. currentYear
	------------------------------------additionalInfo----------------------------------------------------
				RETICLE.additionalInfo:SetText(additionalInfoText) -- "Tickets Available" or time remaining
				RETICLE.additionalInfo:SetColor(additionalInfoLabelColor:UnpackRGBA())
				RETICLE.additionalInfo:SetHidden(false)
				
	------------------------------------------------------------------------------------------------------
				RETICLE.interactKeybindButton:SetText(interactKeybindButtonText) -- cur/max Use or Use
				RETICLE.interactKeybindButton:SetNormalTextColor(interactKeybindButtonColor)
				return interactionBlocked
			end
		end
	end)
]]

--[[

	RETICLE.interact:SetHidden(false)
	RETICLE.interactKeybindButton:SetText(zo_strformat(SI_FORMAT_BULLET_TEXT, GetString(SI_GAME_CAMERA_ACTION_EMPTY)))
	RETICLE.interactKeybindButton:ShowKeyIcon()
	RETICLE.interactKeybindButton:HideKeyIcon()
	RETICLE.additionalInfo:SetHidden(false)
	RETICLE.additionalInfo:SetText(GetString(SI_HOLD_TO_SELECT_BAIT))
]]