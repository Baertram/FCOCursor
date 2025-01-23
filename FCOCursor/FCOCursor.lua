------------------------------------------------------------------
--FCOCursor.lua
--Author: Baertram
------------------------------------------------------------------
--Global variable
FCOCursor                 = {
    name    =           "FCOCursor", -- Matches folder and Manifest file names.
    settingsName =      "FCO Cursor", -- Matches folder and Manifest file names.
    version =           "2.0", -- A nuisance to match to the Manifest.
    author  =           "Baertram",
    website =           "https://www.esoui.com/downloads/fileinfo.php?id=3773",
    feedback =          "https://www.esoui.com/portal.php?id=136&a=faq",
    donation =          "https://www.esoui.com/portal.php?id=136&a=faq&faqid=131",
}
local FCOC                = FCOCursor

--Libraries
FCOC.LAM = LibAddonMenu2


--ZOs controls
FCOC.ctrlVars = {
    guiMouse = GuiMouse,
}

--Saved original cursor data
local origZOsCursors = {
    default = MOUSE_CURSOR_DEFAULT_CURSOR,-- = 0
    resizeEW = MOUSE_CURSOR_RESIZE_EW,-- = 1
    resizeNS = MOUSE_CURSOR_RESIZE_NS,-- = 2
    resizeNESW = MOUSE_CURSOR_RESIZE_NESW,-- = 3
    resizeNWSE = MOUSE_CURSOR_RESIZE_NWSE,-- = 4
    icon = MOUSE_CURSOR_ICON,-- = 5
    uiHand = MOUSE_CURSOR_UI_HAND,-- = 6
    erase = MOUSE_CURSOR_ERASE,-- = 7
    fill = MOUSE_CURSOR_FILL,-- = 8
    fillMultiple = MOUSE_CURSOR_FILL_MULTIPLE,-- = 9
    paint = MOUSE_CURSOR_PAINT,-- = 10
    sample = MOUSE_CURSOR_SAMPLE,-- = 11
    pan = MOUSE_CURSOR_PAN,-- = 12
    rotate = MOUSE_CURSOR_ROTATE,-- = 13
    nextLeft = MOUSE_CURSOR_NEXT_LEFT,-- = 14
    nextRight = MOUSE_CURSOR_NEXT_RIGHT,-- = 15
    preview = MOUSE_CURSOR_PREVIEW,-- = 16
    championWorldStar = MOUSE_CURSOR_CHAMPION_WORLD_STAR,-- = 17
    championCombatStar = MOUSE_CURSOR_CHAMPION_COMBAT_STAR,-- = 18
    championConditioningStar = MOUSE_CURSOR_CHAMPION_CONDITIONING_STAR,-- = 19
    doNotCare = MOUSE_CURSOR_DO_NOT_CARE,-- = 666
}

local savedOrigCursors = {}
for k, v in pairs(origZOsCursors) do
    local savedOrigZOsCursor = v
    savedOrigCursors[k] = savedOrigZOsCursor
end
FCOC.origCursors = savedOrigCursors


--Change this to another cursor if you want to have the default cursor replaced by any other
-->If your chose one is not exisitng it will reset to the original default cursor instead
local newCursorForDefault = MOUSE_CURSOR_CHAMPION_CONDITIONING_STAR

--The actual cursor chosen
local newCursor = nil


--local variables
local isExchangeCursorsLooping = false

--SavedVariables data
local svVersion = 1
local svName = "FCOCursor_Settings"
FCOC.settingsVars = {
    defaults = {
        exchangeCursors = {
            default = true,
        },
        exchangedCursors = {
            default = newCursorForDefault
        },
        cursorGlow = false,
        cursorGlowColor = {r=0.3, g=0.3, b=0.3, a=0.4}
    },
    settings = {},
}

local function getCursorsList()
    local cursorsSorted = {}
    for cursorName, _ in pairs(origZOsCursors) do
        cursorsSorted[#cursorsSorted + 1] = cursorName
    end
    table.sort(cursorsSorted)

    local choices = {}
    local choicesValues = {}
    for idx, cursorName in pairs(cursorsSorted) do
        choices[idx] = cursorName
        local cursor = origZOsCursors[cursorName]
        choicesValues[idx] = cursor
    end

    return choices, choicesValues
end

--functions
local function updateVisualCursorNow()
    --Mouse cursor is not updating if just pressing key to get into UI mode.
    --You need to open the inventory e.g. to update it?
    --So we try to force the change of the cursor now
    ClearCursor()
    WINDOW_MANAGER:SetMouseCursor(MOUSE_CURSOR_DEFAULT_CURSOR)
end

local function replaceCursor(cursorType, newCursor)
    if cursorType == nil then return end
    local cursorToReplace = origZOsCursors[cursorType] --returns e.g. MOUSE_CURSOR_DEFAULT_CURSOR
    if cursorToReplace ~= nil then
        if newCursor == nil then
            cursorToReplace = savedOrigCursors[cursorType]
        else
            cursorToReplace = newCursor
        end
    end

    if isExchangeCursorsLooping then return end
    updateVisualCursorNow()
end

local exchangeCursors
function FCOC.ExchangeCursors(cursorType, newCursor)
    exchangeCursors = exchangeCursors or FCOC.ExchangeCursors
    if cursorType == nil and newCursor == nil  then
        --Loop over all exchanged cursors and set them to their exchanged value now
        local exchangeCursorsSettigs = FCOC.settingsVars.settings.exchangeCursors
        isExchangeCursorsLooping = true
        for l_cursorType, l_newCursor in pairs(exchangeCursorsSettigs) do
            exchangeCursors(l_cursorType, l_newCursor)
        end
        isExchangeCursorsLooping = false
        updateVisualCursorNow()
    else
        replaceCursor(cursorType, newCursor)
    end
end
exchangeCursors = FCOC.ExchangeCursors

--Settings menu
local function BuildAddonMenu()
        local defSettings = FCOC.settingsVars.defaults
        local settings = FCOC.settingsVars.settings

        local panelData = {
            type 				= 'panel',
            name 				= FCOC.settingsName,
            displayName 		= FCOC.settingsName,
            author 				= FCOC.author,
            version 			= FCOC.version,
            registerForRefresh 	= true,
            registerForDefaults = true,
            slashCommand 		= "/fcocursors",
            website             = FCOC.website,
            feedback            = FCOC.feedback,
            donation            = FCOC.donation,
        }
        --The LibAddonMenu2.0 settings panel reference variable
        FCOC.LAMsettingsPanel = FCOC.LAM:RegisterAddonPanel(FCOC.name .. "_LAM", panelData)

        --Callback as the FCOCursor LAm panel was created
        --[[
        local function FCOC_LAMPanelCreated()

        end
        ]]

        local cursorsDropdownChoices, cursorsDropdownChoicesValues = getCursorsList()


        --the LAM settings controls
        local optionsTable = {
            --==============================================================================
            {
                type = 'header',
                name = GetString(FCOCURSOR_LAM_HEADER_EXCHANGE_CURSOR),
            },
            --==============================================================================
            {
                type = "dropdown",
                name = GetString(FCOCURSOR_LAM_EXCHANGE_DEFAULT_CURSOR),
                tooltip = GetString(FCOCURSOR_LAM_EXCHANGE_DEFAULT_CURSOR_TT),
                choices = cursorsDropdownChoices,
                choicesValues = cursorsDropdownChoicesValues,
                getFunc = function () return self.savedVars.cursor end,
                setFunc = function (value)
                    FCOC.settingsVars.settings.exchangeCursors["default"] = value
                    exchangeCursors("default", value)
                end,
                width = "full",
            }

            --[[
            --==============================================================================
            {
                type = 'header',
                name = GetString(FCOCURSOR_LAM_HEADER_CURSOR_VISUALS),
            },
            --==============================================================================
            {
                type = "checkbox",
                name = GetString(FCOCURSOR_LAM_CURSOR_GLOW),
                tooltip = GetString(FCOCURSOR_LAM_CURSOR_GLOW_TT),
                getFunc = function() return settings.cursorGlow end,
                setFunc = function(value)
                    FCOC.settingsVars.settings.cursorGlow = value
                end,
                default = defSettings.cursorGlow,
            },
            {
                type = "colorpicker",
                name = GetString(FCOCURSOR_LAM_CURSOR_GLOW_COLOR),
                tooltip = GetString(FCOCURSOR_LAM_CURSOR_GLOW_COLOR_TT),
                getFunc = function()
                    local cursorGlowColor = settings.cursorGlowColor
                    return cursorGlowColor["r"], cursorGlowColor["g"], cursorGlowColor["b"], cursorGlowColor["a"]
                end,
                setFunc = function(r,g,b,a)
                    local cursorGlowColor = FCOC.settingsVars.settings.cursorGlowColor
                    cursorGlowColor["r"] = r
                    cursorGlowColor["g"] = g
                    cursorGlowColor["b"] = b
                    cursorGlowColor["a"] = a
                end,
                efault = defSettings.cursorGlowColor,
                disabled = function() return not settings.cursorGlow end,
            },
            ]]

        }

        --CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", FCOC_LAMPanelCreated)
        FCOC.LAM:RegisterOptionControls(FCOC.name .. "_LAM", optionsTable)
end

local function LoadSavedVariables()
    FCOC.settingsVars.settings = ZO_SavedVars:NewCharacterIdSettings(svName, svVersion, GetWorldName(), FCOC.settingsVars.defaults, nil)
end

--Events
function FCOC.OnPlayerActivated(event)
    --Check if any cursor should be exchanged
    FCOC.ExchangeCursors(nil, nil)
end

function FCOC.OnAddOnLoaded(event, addonName)
    if addonName ~= FCOC.name then return end
    EVENT_MANAGER:UnregisterForEvent(FCOC.name, EVENT_ADD_ON_LOADED)

    FCOC.InitCursorXML()

    LoadSavedVariables()
    BuildAddonMenu()

    EVENT_MANAGER:RegisterForEvent(FCOC.name, EVENT_PLAYER_ACTIVATED, FCOC.OnPlayerActivated)
end


--XML Initialization
function FCOC.InitCursorXML()
    FCOC.UITLC = FCOCursorTLC
end

--Load the addon
EVENT_MANAGER:RegisterForEvent(FCOC.name, EVENT_ADD_ON_LOADED, FCOC.OnAddOnLoaded)

