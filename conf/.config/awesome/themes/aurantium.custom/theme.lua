---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "UbuntuCondenced 12"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#2d2d2d"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#888888"

theme.useless_gap = 0
theme.border_width  = "0"
theme.border_normal = "#000000"
theme.border_focus  = "#222222"
theme.border_marked = "#ff6600"

-- Display the taglist squares
theme.taglist_squares_sel   = "@AWESOME_THEMES_PATH@/aurantium.custom/taglist/square_a.png"
theme.taglist_squares_unsel = "@AWESOME_THEMES_PATH@/aurantium.custom/taglist/square_b.png"

theme.tasklist_floating_icon = "@AWESOME_THEMES_PATH@/aurantium.custom/tasklist/maximized.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "@AWESOME_THEMES_PATH@/aurantium.custom/submenu.png"
theme.menu_height = 16
theme.menu_width  = 150

-- You can use your own command to set your wallpaper
theme.wallpaper = "@AWESOME_THEMES_PATH@/aurantium.custom/wallpaper.jpg"

-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/themes/aurantium.custom/layouts/tile.png"
theme.layout_tileleft   = "~/.config/awesome/themes/aurantium.custom/layouts/tileleft.png"
theme.layout_tiletop = "~/.config/awesome/themes/aurantium.custom/layouts/tiletop.png"
theme.layout_floating  = "~/.config/awesome/themes/aurantium.custom/layouts/floating.png"
theme.layout_max = "~/.config/awesome/themes/aurantium.custom/layouts/max.png"
theme.layout_fairh = "~/.config/awesome/themes/aurantium.custom/layouts/fairh.png"
theme.layout_fairv = "~/.config/awesome/themes/aurantium.custom/layouts/fairv.png"
theme.layout_spiral = "~/.config/awesome/themes/aurantium.custom/layouts/spiral.png"
theme.layout_fullscreen = "~/.config/awesome/themes/aurantium.custom/layouts/fullscreen.png"

-- theme.awesome_icon = "~/.config/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
