
local LIB_IDENTIFIER, LIB_VERSION = "LibInteractionFilters", 03
if _G[LIB_IDENTIFIER] and _G[LIB_IDENTIFIER].version > LIB_VERSION then
	return
end

local lib = {}
lib.name = LIB_IDENTIFIER
lib.version = LIB_VERSION
_G[LIB_IDENTIFIER] = lib

-----------------------------------------------------------------------------
-- actionFilters
-----------------------------------------------------------------------------
local actionFilters = {
	'LIB_IF_ACTIONTYPE_SEARCH',		-- Search - loot
	'LIB_IF_ACTIONTYPE_TALK',		-- Talk
	'LIB_IF_ACTIONTYPE_HARVEST',	-- Harvest (Mine, Cut, Collect)
	'LIB_IF_ACTIONTYPE_DISARM',		-- Disarm
	'LIB_IF_ACTIONTYPE_USE',		-- Use
	'LIB_IF_ACTIONTYPE_READ',		-- Read
	'LIB_IF_ACTIONTYPE_TAKE',		-- Take
	'LIB_IF_ACTIONTYPE_DESTROY',	-- Destroy
	'LIB_IF_ACTIONTYPE_REPAIR',		-- Repair
	'LIB_IF_ACTIONTYPE_INSPECT',	-- Inspect
	'LIB_IF_ACTIONTYPE_REPAIR2',	-- Repair
	'LIB_IF_ACTIONTYPE_UNLOCK',		-- Unlock
	'LIB_IF_ACTIONTYPE_OPEN',		-- Open
	'',-- LIB_IF_ACTIONTYPE_			= 14	-- SI_GAMECAMERAACTIONTYPE14 is nil
	'LIB_IF_ACTIONTYPE_EXAMINE',	-- Examine
	'LIB_IF_ACTIONTYPE_FISH',		-- Fish
	'LIB_IF_ACTIONTYPE_REELIN',		-- Reel In
	'LIB_IF_ACTIONTYPE_PACKUP',		-- Pack Up
	'LIB_IF_ACTIONTYPE_STEAL',		-- Steal
	'LIB_IF_ACTIONTYPE_STEALFROM',	-- Steal from
	'LIB_IF_ACTIONTYPE_PICKPOCKET',	-- Pickpocket
	'',--LIB_IF_ACTIONTYPE_			= 22	-- SI_GAMECAMERAACTIONTYPE22 is nil
	'LIB_IF_ACTIONTYPE_TRESPASS',	-- Trespass
	'LIB_IF_ACTIONTYPE_HIDE',		-- Hide
	'LIB_IF_ACTIONTYPE_PREVIEW',	-- Preview
	'LIB_IF_ACTIONTYPE_EXIT',		-- Exit
	'LIB_IF_ACTIONTYPE_EXCAVATE',	-- Excavate
	'LIB_IF_ACTIONTYPE_MINE',		-- Mine
	'LIB_IF_ACTIONTYPE_CUT',		-- Cut
	'LIB_IF_ACTIONTYPE_COLLECT',	-- Collect
	'LIB_IF_ACTIONTYPE_COLLECT',	-- Capture

}

-- "Registring" the actionFilters to global
for i, actionFilter in ipairs(actionFilters) do
	if actionFilter ~= '' then
		_G[actionFilter] = i
	end
end

-----------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------
-- Lets just clone the default strings as our own.
for i=1, 27 do
	_G['SI_LIB_IF_GAMECAMERAACTIONTYPE' .. i] = _G['SI_GAMECAMERAACTIONTYPE' .. i]
end

-----------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------
local lib_reticle = RETICLE

function lib:IterateOverActions(action)
	local actionFilters = self.actionFilters[action] or {}
	local nextKey, nextData = next(actionFilters)
	checkAll = true
	return function()
		while nextKey do
			local registerdName, filterFunction = nextKey, nextData
			nextKey, nextData = next(actionFilters, nextKey)
			
			if filterFunction then
				return filterFunction
			end
		end
	end
end

-- where ... = interactableName, interactionPossible, currentFrameTimeSeconds
function lib:IsInteractionDisabled(action, ...)
	local isDisabled = false

	for k, _action in ipairs({'all', action}) do
		for filterFunction in self:IterateOverActions(_action) do
			if filterFunction(action, ...) then
				isDisabled = true
			end
		end
	end

	return isDisabled
end

-- where ... = interactionPossible, currentFrameTimeSeconds
function lib:OnTryHandelingInteraction(...)
	local action, interactableName = GetGameCameraInteractableActionInfo()

	self.interactionDisabled = self:IsInteractionDisabled(action, interactableName, ...)
	if self.interactionDisabled then
		-- set the interaction as blocked, to gray out the keybind
		lib_reticle.interactionBlocked = self.interactionDisabled
	end
end

-----------------------------------------------------------------------------
-- Un/Register
-----------------------------------------------------------------------------
function lib:RegisterForOnTryHandlingInteractionCallback(registerdName, action, filter)
	if type(action) == 'function' then
		filter = action
		action = 'all'
	end
	if type(action) == 'number' then
		action = GetString(action)
	end
	
	local actionFilters = self.actionFilters or {}
	self.actionFilters = actionFilters
	local actionFilter = actionFilters[action] or {}
	actionFilters[action] = actionFilter
	
	-- where ... = action, interactableName, interactionPossible, currentFrameTimeSeconds
	actionFilter[registerdName] = function(...)
		return filter(...)
	end
end

function lib:UnregisterForOnTryHandlingInteractionCallback(registerdName, action)
	if type(action) == 'number' then
		action = GetString(action)
	else
		action = action or 'all'
	end
	
	local actionFilters = self.actionFilters or {}
	self.actionFilters = actionFilters
	local actionFilter = actionFilters[action] or {}
	actionFilters[action] = actionFilter
	actionFilter[registerdName] = nil
	
	if NonContiguousCount(actionFilters[action]) == 0 then
		self.actionFilters[action] = nil
	end
end

-----------------------------------------------------------------------------
-- Get action info
-----------------------------------------------------------------------------
-- Post the list of actions and thier actionFilter to chat
function lib:ListAllActionsInfo()
	for i, actionFilter in ipairs(actionFilters) do
		if actionFilter ~= '' then
			d( zo_strformat('<<1>> = <<2>>, String = <<3>>', actionFilter, i, GetString('SI_LIB_IF_GAMECAMERAACTIONTYPE', i)))
		end
	end
end

-- returns [table]actionsInfo
function lib:GetAllActionsInfo()
	local actionsInfo = {}
	for i, actionFilter in ipairs(actionFilters) do
		if actionFilter ~= '' then
			local newEntry = {
					actionFilter = i,
					constant = actionFilter,
					action = GetString('SI_LIB_IF_GAMECAMERAACTIONTYPE', i)
				}
			table.insert(actionsInfo, newEntry)
		end
	end
	return actionsInfo
end

LIB_INTERACTION_FILTERS = lib
--	/script LIB_INTERACTION_FILTERS:ListAllActionsInfo()
--	/tb LIB_INTERACTION_FILTERS:GetAllActionsInfo()
-----------------------------------------------------------------------------
-- Hook
-----------------------------------------------------------------------------
-- RETICLE.interactionDisabled is added and used to prevent interaction at INTERACTIVE_WHEEL_MANAGER:StartInteraction()
-- Setting RETICLE.interactionBlocked to true will cause the reticle keybind to turn gray.
SecurePostHook(lib_reticle, "TryHandlingInteraction", function(self, interactionPossible, currentFrameTimeSeconds)
	if not interactionPossible then return end
	
	lib:OnTryHandelingInteraction(interactionPossible, currentFrameTimeSeconds)
end)

-----------------------------------------------------------------------------
-- Disabling interaction.
-----------------------------------------------------------------------------
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
