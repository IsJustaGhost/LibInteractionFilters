This is a library is used to hook "RETICLE:TryHandlingInteraction" and to effectively disable target interactions by registering functions

Functions are registered by add-on per action with the actionName("Talk"), or the stringId, (SI_LIB_IF_GAMECAMERAACTIONTYPE2)
"self.actionFilters[action][registerdName] = function"
Or by addon for any action, by ommiting the action name while registering.
"self.actionFilters['Any Action'][registerdName] = function"

"action" is the string that's used on target interactions keybind. "Talk", "Steel" 
local action, interactableName = GetGameCameraInteractableActionInfo()

```
local function tryHandlingInteractionCallback(action, interactableName, currentFrameTimeSeconds)
	if isActionDisabled(action, interactableName, currentFrameTimeSeconds) then
		-- Disabled
		return true
	end
	return false
end


-- Register for specific actions
	LIB_INTERACTION_HOOK:RegisterOnTryHandlingInteraction("Addon_Name", actionName, tryHandlingInteractionCallback)

-- Register for any action by ommiting actionName
	LIB_INTERACTION_HOOK:RegisterOnTryHandlingInteraction("Addon_Name",  tryHandlingInteractionCallback)
```
The function, isActionDisabled, is the filter used in [URL="https://www.esoui.com/downloads/info3136-IsJustaDisableActionsWhileMoving.html"]IsJusta Disable Actions While Moving[/URL].
		
Filters may also be unregistered.
```
	LIB_INTERACTION_HOOK:UnregisterOnTryHandlingInteraction("Addon_Name", actionName)
	LIB_INTERACTION_HOOK:UnregisterOnTryHandlingInteraction("Addon_Name")
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
