This library is used as a alternitive method to hooking "RETICLE:TryHandlingInteraction", and can be used to effectively disable target interactions, by registering functions.<br>
Interaction states are near instantly updated on looking away from the current target, or on state desireability changed in the registerd functions<br>

In gamepad mode, the method this uses to disable target interactions does not prevent jumping.<br>
Disabled interactions are not hidden but, the keybind button and action are grayed out. <br>
If hiding the interaction is desired, adding "LibInteractionHook.HideInteraction()" to the registered function is all that's needed.

Functions are registered, by add-on, per action with the actionName("Talk"), or the stringId, (SI_LIB_IF_GAMECAMERAACTION2)<br>
"lib.actionFilters[action][registerdName] = function"<br>
Or, by addon, for any action, by ommiting the action while registering.<br>
"lib.actionFilters['Any Action'][registerdName] = function"<br>

"action" is the string that's used on target interactions keybind. "Talk", "Steel" 
```
local action, interactableName = GetGameCameraInteractableActionInfo()
```
```
local registerOnTryHandlingInteraction = LibInteractionHook.RegisterOnTryHandlingInteraction

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
	registerOnTryHandlingInteraction("Addon_Name", actionName, tryHandlingInteraction)

-- Register for any action by ommiting actionName
	registerOnTryHandlingInteraction("Addon_Name",  tryHandlingInteraction)
```
The function, isActionDisabled, is the filter used in version 2.1 and above of, https://www.esoui.com/downloads/info3136-IsJustaDisableActionsWhileMoving.html.
		
Filters may also be unregistered.
```
local unregisterOnTryHandlingInteraction = LibInteractionHook.UnregisterOnTryHandlingInteraction

	unregisterOnTryHandlingInteraction("Addon_Name", actionName)
	unregisterOnTryHandlingInteraction("Addon_Name")
```

Changing the interaction text displayed
```
	local function tryHandlingInteraction(object, action, interactableName, currentFrameTimeSeconds)
		if action and interactableName then
			if self.savedVars.eventActive then
				local additionalInfoText, interactKeybindButtonText, interactionBlocked, interactKeybindButtonColor, additionalInfoLabelColor = getInterationInfo(action, interactableName)
				
				object.interactContext:SetText(interactableName) -- "Jubilee Cake" .. currentYear
	------------------------------------additionalInfo----------------------------------------------------
				object.additionalInfo:SetText(additionalInfoText) -- "Tickets Available" or time remaining
				object.additionalInfo:SetColor(additionalInfoLabelColor:UnpackRGBA())
				object.additionalInfo:SetHidden(false)
				
	------------------------------------------------------------------------------------------------------
				object.interactKeybindButton:SetText(interactKeybindButtonText) -- cur/max Use or Use
				object.interactKeybindButton:SetNormalTextColor(interactKeybindButtonColor)
				return true
			end
		end
		return false
	end
	
	registerOnTryHandlingInteraction(self.name, LIB_IF_GAMECAMERAACTION_USE, function(action, interactableName, currentFrameTimeSeconds)
		if self:IsTargetForTickets(interactableName) then
			return tryHandlingInteraction(RETICLE, action, interactableName, currentFrameTimeSeconds)
		end
	end)
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
