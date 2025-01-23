------------------------------------------------------------------
--FCOCursor.lua
--Author: Baertram
------------------------------------------------------------------
--Global variable
FCOCursor                 = {
    name    = "FCOCursor", -- Matches folder and Manifest file names.
    version = "1.0", -- A nuisance to match to the Manifest.
    author  = "Baertram",
}
local FCOC                = FCOCursor

--local guiMouse = GuiMouse

local origDoNotCareCursor   = MOUSE_CURSOR_DO_NOT_CARE
FCOC.origDoNotCareCursor    = origDoNotCareCursor
local origDefaultCursor     = MOUSE_CURSOR_DEFAULT_CURSOR
FCOC.origDefaultCursor      = origDefaultCursor

--Change this to another cursor if you want to have the default cursor replaced by any other
-->If your chose one is not exisitng it will reset to the original default cursor instead
local newCursorForDefault = MOUSE_CURSOR_CHAMPION_CONDITIONING_STAR
FCOC.origDefaultCursor    = newCursorForDefault

local function replaceDefaultCursor(newCursor)
    if newCursor == nil then
        MOUSE_CURSOR_DEFAULT_CURSOR = origDefaultCursor
        MOUSE_CURSOR_DO_NOT_CARE = origDoNotCareCursor
        return
    end
    --Replace the default cursor with another one
    MOUSE_CURSOR_DEFAULT_CURSOR = newCursor
	MOUSE_CURSOR_DO_NOT_CARE = newCursor

    --Mouse cursor is not updating if just pressing key to get into UI mode.
    --You need to open the inventory e.g. to update it?
    --So we try to force the change of the cursor now
    ClearCursor()
    WINDOW_MANAGER:SetMouseCursor(MOUSE_CURSOR_DEFAULT_CURSOR)
end

function FCOC.OnPlayerActivated(event)
    replaceDefaultCursor(newCursorForDefault)
end

function FCOC.OnAddOnLoaded(event, addonName)
    if addonName ~= FCOC.name then return end
    EVENT_MANAGER:UnregisterForEvent(FCOC.name, EVENT_ADD_ON_LOADED)
    EVENT_MANAGER:RegisterForEvent(FCOC.name, EVENT_PLAYER_ACTIVATED, FCOC.OnPlayerActivated)
end
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(FCOC.name, EVENT_ADD_ON_LOADED, FCOC.OnAddOnLoaded)