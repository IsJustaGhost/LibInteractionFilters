This library is used to hook "RETICLE:TryHandlingInteraction", and can be used to effectively disable target interactions, by registering functions.<br>
Interaction states are near instantly updated on looking away from the current target, or on state desireability changed in the registerd functions<br>

In gamepad mode, the method this uses to disable target interactions does not prevent jumping.<br>
Disabled interactions are not hidden but, the keybind button and action are grayed out. <br>
If hiding the interaction is desired, adding "LIB_INTERACTION_HOOK:HideInteraction()" to the registered function is all that's needed.

Functions are registered, by add-on, per action with the actionName("Talk"), or the stringId, (SI_LIB_IF_GAMECAMERAACTIONTYPE2)<br>
"lib.actionFilters[action][registerdName] = function"<br>
Or, by addon, for any action, by ommiting the action while registering.<br>
"lib.actionFilters['Any Action'][registerdName] = function"<br>

"action" is the string that's used on target interactions keybind. "Talk", "Steel" 
```
local action, interactableName = GetGameCameraInteractableActionInfo()
```
```
local function tryHandlingInteraction(action, interactableName, interactionPossible, currentFrameTimeSeconds)
	if not interactionPossible then return end
	if isActionDisabled(action, interactableName, currentFrameTimeSeconds) then
		-- Disabled
		-- should it hide it?
		LIB_INTERACTION_HOOK:HideInteraction()
		return true
	end
	return false
end


-- Register for specific actions
	LIB_INTERACTION_HOOK:RegisterOnTryHandlingInteraction("Addon_Name", actionName, tryHandlingInteraction)

-- Register for any action by ommiting actionName
	LIB_INTERACTION_HOOK:RegisterOnTryHandlingInteraction("Addon_Name",  tryHandlingInteraction)
```
The function, isActionDisabled, is the filter used in [URL="https://www.esoui.com/downloads/info3136-IsJustaDisableActionsWhileMoving.html"]IsJusta Disable Actions While Moving[/URL].
		
Filters may also be unregistered.
```
	LIB_INTERACTION_HOOK:UnregisterOnTryHandlingInteraction("Addon_Name", actionName)
	LIB_INTERACTION_HOOK:UnregisterOnTryHandlingInteraction("Addon_Name")
```

Can also be used to monitor Reticle target for updates.
```
local function tryHandlingInteraction(action, interactableName, interactionPossible, currentFrameTimeSeconds)
	if not interactionPossible then return end
	if currentFrameTimeSeconds > cooldown and tableOfNames[interactableName] then
		cooldown = currentFrameTimeSeconds + 30
		-- do the things
	end
end
```
