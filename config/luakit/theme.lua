--------------------------
-- Default luakit theme --
--------------------------

local fg = "#676767"
local bg = "#f4f4f4"
local green = "#7c9f4b"
local red = "#db7070"
local blue = "#6587BF"
local med_gray = "#aaa"

local theme = {}

-- Default settings
theme.font = "16px Inter"
theme.fg   = fg
theme.bg   = bg

-- Genaral colours
theme.success_fg = "#0f0"
theme.loaded_fg  = "#33AADD"
theme.error_fg = "#FFF"
theme.error_bg = "#F00"

-- Warning colours
theme.warning_fg = "#F00"
theme.warning_bg = "#FFF"

-- Notification colours
theme.notif_fg = "#444"
theme.notif_bg = "#FFF"

-- Menu colours
theme.menu_fg                   = fg
theme.menu_bg                   = bg
theme.menu_selected_fg          = bg
theme.menu_selected_bg          = fg
theme.menu_title_bg             = bg
theme.menu_primary_title_fg     = fg
theme.menu_secondary_title_fg   = "#666"

theme.menu_disabled_fg = "#999"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg = theme.menu_fg
theme.menu_enabled_bg = theme.menu_bg
theme.menu_active_fg = "#060"
theme.menu_active_bg = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg      = '#000'
theme.proxy_active_menu_bg      = '#FFF'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#FFF'

-- Statusbar specific
theme.sbar_fg         = fg
theme.sbar_bg         = bg

-- Downloadbar specific
theme.dbar_fg         = "#fff"
theme.dbar_bg         = "#000"
theme.dbar_error_fg   = "#F00"

-- Input bar specific
theme.ibar_fg           = fg
theme.ibar_bg           = bg

-- Tab label
theme.tab_fg            = fg
theme.tab_bg            = bg
theme.tab_hover_bg      = med_gray
theme.tab_ntheme        = "#ddd"
theme.selected_fg       = bg
theme.selected_bg       = fg
theme.selected_ntheme   = "#ddd"
theme.loading_fg        = blue
theme.loading_bg        = "#000"

theme.selected_private_tab_bg = "#3d295b"
theme.private_tab_bg    = "#22254a"

-- Trusted/untrusted ssl colours
theme.trust_fg          = green
theme.notrust_fg        = red

-- Follow mode hints
theme.hint_font = "12px SF Mono, courier, sans-serif"
theme.hint_fg = "#fff"
theme.hint_bg = "#000088"
theme.hint_border = "1px dashed #000"
theme.hint_opacity = "0.3"
theme.hint_overlay_bg = "rgba(255,255,153,0.3)"
theme.hint_overlay_border = "1px dotted #000"
theme.hint_overlay_selected_bg = "rgba(0,255,0,0.3)"
theme.hint_overlay_selected_border = theme.hint_overlay_border

-- General colour pairings
theme.ok = { fg = fg, bg = bg }
theme.warn = { fg = "#F00", bg = "#FFF" }
theme.error = { fg = "#FFF", bg = "#F00" }

-- Gopher page style (override defaults)
theme.gopher_light = { bg = "#E8E8E8", fg = "#17181C", link = "#03678D" }
theme.gopher_dark  = { bg = "#17181C", fg = "#E8E8E8", link = "#f90" }

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
