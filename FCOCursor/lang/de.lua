local stringsDE = {
    --LAM settings
    FCOCURSOR_LAM_HEADER_EXCHANGE_CURSOR     = "Cursor Austauch",
    FCOCURSOR_LAM_EXCHANGE_DEFAULT_CURSOR    = "Tausche Standard Cursor aus",
    FCOCURSOR_LAM_EXCHANGE_DEFAULT_CURSOR_TT = "Tauscht den Standard Cursor gegen den Championpunkte Stern (rot) Cursor aus -> Bessere Sichtbarkeit",
    FCOCURSOR_LAM_HEADER_CURSOR_VISUALS      = "Visuelle Cursor Veränderungen",
    FCOCURSOR_LAM_CURSOR_GLOW                = "Glühen um den Cursor",
    FCOCURSOR_LAM_CURSOR_GLOW_TT             = "Zeigt einen glühenden Effekt um den Cursor herum an",
    FCOCURSOR_LAM_CURSOR_GLOW_COLOR          = "Glühen Farbe",
    FCOCURSOR_LAM_CURSOR_GLOW_COLOR_TT       = "Die Farbe für den Glühen Effekt"

}
for stringId, stringValue in pairs(stringsDE) do
    SafeAddString(_G[stringId], stringValue, 2)
end
