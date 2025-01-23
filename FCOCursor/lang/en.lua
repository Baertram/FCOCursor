local stringsEN = {
    --LAM settings
    FCOCURSOR_LAM_HEADER_EXCHANGE_CURSOR    =   "Exchange cursors",
    FCOCURSOR_LAM_EXCHANGE_DEFAULT_CURSOR   =   "Exchange the default cursor",
    FCOCURSOR_LAM_EXCHANGE_DEFAULT_CURSOR_TT =  "Exchange the default cursor with the Champion Star (red) cursor -> Better visibility",
    FCOCURSOR_LAM_HEADER_CURSOR_VISUALS    =    "Visual cursor changes",
    FCOCURSOR_LAM_CURSOR_GLOW    =              "Glow around the cursor",
    FCOCURSOR_LAM_CURSOR_GLOW_TT    =           "Show a glowing effect around the cursor",
    FCOCURSOR_LAM_CURSOR_GLOW_COLOR =           "Glow color",
    FCOCURSOR_LAM_CURSOR_GLOW_COLOR_TT  =       "The color for the glow"
}

for stringId, stringValue in pairs(stringsEN) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end