This is a library meant for disabling target interactions by filters.
It can also be used to to monitor or as a way to change interaction information. 

Filters are registered by add-on per action.
"self.actionFilters[action][registerdName] = function"
Or by addon for all actions, by ommiting the action name while registering.
"self.actionFilters['all'][registerdName] = function"

```
local function tryHandlingInteractionCallback(action, interactableName, currentFrameTimeSeconds)
	if isActionDisabled(action, interactableName, currentFrameTimeSeconds) then
		-- Disabled
		return true
	end
	return false
end


-- Register for specific actions
	LIB_INTERACTION_FILTERS:RegisterForOnTryHandlingInteractionCallback("Addon_Name", actionName, tryHandlingInteractionCallback)

-- Register for any action by ommiting actionName
	LIB_INTERACTION_FILTERS:RegisterForOnTryHandlingInteractionCallback("Addon_Name",  tryHandlingInteractionCallback)
```
local action, interactableName = GetGameCameraInteractableActionInfo()
The function, isActionDisabled, is the filter used in [URL="https://www.esoui.com/downloads/info3136-IsJustaDisableActionsWhileMoving.html"]IsJusta Disable Actions While Moving[/URL].
		
Filters may also be unregistered.
```
	LIB_INTERACTION_FILTERS:UnregisterForOnTryHandlingInteractionCallback("Addon_Name", actionName)
	LIB_INTERACTION_FILTERS:UnregisterForOnTryHandlingInteractionCallback("Addon_Name")
```

Can also be used to monitor Reticle target for updates.
```
local function tryHandlingInteractionCallback(action, interactableName, currentFrameTimeSeconds)
	if currentFrameTimeSeconds > lastTime and tableOfNames[interactableName] then
		lastTime = currentFrameTimeSeconds + 30
		-- do the things
	end
	
end
```
