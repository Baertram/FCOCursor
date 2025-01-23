local stringsDE = {
    --LAM settings
    FCOCURSOR_LAM_HEADER_EXCHANGE_CURSOR     = "Cursor Austauch",
    FCOCURSOR_LAM_EXCHANGE_DEFAULT_CURSOR    = "Tausche Standard Cursor aus",
    FCOCURSOR_LAM_EXCHANGE_DEFAULT_CURSOR_TT = "Tauscht den Standard Cursor gegen den Championpunkte Stern (rot) Cursor aus -> Bessere Sichtbarkeit",
    FCOCURSOR_LAM_HEADER_CURSOR_VISUALS      = "Visuelle Cursor Veränderungen",
    FCOCURSOR_LAM_CURSOR_GLOW                = "Glühen um den Cursor",
    FCOCURSOR_LAM_CURSOR_GLOW_TT             = "Zeigt einen glühenden Effekt um den Cursor herum an",
    FCOCURSOR_LAM_CURSOR_GLOW_COLOR          = "Glühen Farbe",
    FCOCURSOR_LAM_CURSOR_GLOW_COLOR_TT       = "Die Farbe für den Glühen Effekt",

    --Cursor types for the dropdown
    FCOCURSOR_LAM_CURSOR_TYPE_default = "Default System Cursor",
    FCOCURSOR_LAM_CURSOR_TYPE_resizeEW = "East-West Resize",
    FCOCURSOR_LAM_CURSOR_TYPE_resizeNS = "North-South Resize",
    FCOCURSOR_LAM_CURSOR_TYPE_resizeNESW = "Northeast-Southwest Resize",
    FCOCURSOR_LAM_CURSOR_TYPE_resizeNWSE = "Northwest-Southeast Resize",
    FCOCURSOR_LAM_CURSOR_TYPE_icon = "Icon",
    FCOCURSOR_LAM_CURSOR_TYPE_uiHand = "UI Hand",
    FCOCURSOR_LAM_CURSOR_TYPE_erase = "Eraser",
    FCOCURSOR_LAM_CURSOR_TYPE_fill = "Fill",
    FCOCURSOR_LAM_CURSOR_TYPE_fillMultiple = "Fill Multiple",
    FCOCURSOR_LAM_CURSOR_TYPE_paint = "Paint",
    FCOCURSOR_LAM_CURSOR_TYPE_sample = "Sample",
    FCOCURSOR_LAM_CURSOR_TYPE_pan = "Pan",
    FCOCURSOR_LAM_CURSOR_TYPE_rotate = "Rotate",
    FCOCURSOR_LAM_CURSOR_TYPE_nextLeft = "Next Left",
    FCOCURSOR_LAM_CURSOR_TYPE_nextRight = "Next Right",
    FCOCURSOR_LAM_CURSOR_TYPE_preview = "Preview",
    FCOCURSOR_LAM_CURSOR_TYPE_championWorldStar = "Champion World Star",
    FCOCURSOR_LAM_CURSOR_TYPE_championCombatStar = "Champion Combat Star",
    FCOCURSOR_LAM_CURSOR_TYPE_championConditioningStar = "Champion Conditioning Star",
    FCOCURSOR_LAM_CURSOR_TYPE_doNotCare = "Do not care",
}
for stringId, stringValue in pairs(stringsDE) do
    SafeAddString(_G[stringId], stringValue, 2)
end
