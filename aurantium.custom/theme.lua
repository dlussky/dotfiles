---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "Ubuntu 10"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#000000"

theme.fg_normal     = "#eeeeee"
theme.fg_focus      = "#ff6600"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#888888"

theme.border_width  = "0"
theme.border_normal = "#000000"
theme.border_focus  = "#888888"
theme.border_marked = "#ff6600"

-- Display the taglist squares
theme.taglist_squares_sel   = "~/.config/awesome/themes/aurantium.custom/taglist/square_a.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/aurantium.custom/taglist/square_b.png"

theme.tasklist_floating_icon = "~/.config/awesome/themes/aurantium.custom/tasklist/maximized.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/themes/aurantium.custom/submenu.png"
theme.menu_height = 16
theme.menu_width  = 150

-- You can use your own command to set your wallpaper
theme.wallpaper = "~/.config/awesome/themes/aurantium.custom/wallpaper.jpg"

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
