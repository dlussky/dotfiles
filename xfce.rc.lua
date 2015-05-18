-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local beautiful = require("beautiful")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/aurantium.custom/theme.lua")

-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

-- This is used later as the default terminal and editor to run.
terminal = "guake"
editor = "subl"
editor_cmd = editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.floating,
    awful.layout.suit.spiral,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.



autofocus_timer = timer { timeout = 0.1 }
autofocus_timer:connect_signal("timeout", function()
  autofocus_timer:stop()
  local focusedClient = client.focus
  if (focusedClient ~= nil) then
    if (focusedClient.name == "xfce4-panel") or (focusedClient.class == "Xfdesktop") or (focusedClient.name == "xfce4-nofityd") then
      local c = awful.client.getmaster()
      if (c == nil) then
        c = awful.client.focus.byidx(1)
      end
      if c then
        client.focus = c
        c:raise()
      end
    end
  end
end)

tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "1", "2", "3", "4", "5", "6"}, s, layouts[1])

    for t = 1, 6 do
       tags[s][t]:connect_signal("property::selected", function() 
          local tag = awful.tag.selected();
          if (tag ~= nil) then 
            -- guileful xfce minions hadn't stolen the focus yet, we need to wait
            autofocus_timer:again()
          end
        end)
    end
end
-- }}}


-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore)

    -- Prompt

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) if (c.name ~= "xfce4-panel") then c:kill() end end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            if (c.name ~= "xfce4-panel") then c.minimized = true end
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
		      if client.focus then
                        local tag = awful.tag.gettags(client.focus.screen)[i]
                        if tag then
                            awful.client.movetotag(tag)
		        end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
		      if client.focus then
                      	local tag = awful.tag.gettags(client.focus.screen)[i]
                      	if tag then
                          awful.client.toggletag(tag)
                      	end
		      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = 0,
                     focus = awful.client.focus.filter,
                     size_hints_honor = false,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Skype" },
      properties = { focusable = true },
      callback = awful.placement.centered },
    { rule = { class = "Plugin-container" },
      properties = { fullscreen = true, floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { state = "modal" },
      properties = { floating = true, ontop = true },
      callback = awful.placement.centered },
    { rule = { type="dialog" },
      properties = { floating = true, ontop = true },
      callback = awful.placement.centered },
    { rule = { class = "Xfce4-settings-manager" },
      properties = { ontop = false, floating = true } },
    { rule = { class = "Xfce4-appfinder" },
      properties = { floating = true, ontop = true },
      callback = awful.placement.centered },
    { rule = { class = "Update-manager" },
      properties = { floating = true, ontop = true },
      callback = awful.placement.centered },
    { rule = { class = "Xfce4-notifyd" },
      properties = { focusable = false } },

    { rule = { name = "Whisker Menu" },
      properties = { floating = true, ontop = true },
      callback = function( c )
           c:geometry( { width = 400 , height = 600, x = 0, y = 480 } )
      end 
    },
    { rule = { class = "Guake" },
      properties = { maximized_vertical = true, maximized_horizontal = true, floating = true, sticky = true } },

    { rule = { class = "Xfdesktop" },
      properties = { sticky = true, focusable = false } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)


autoraise_target = nil
autoraise_timer = timer { timeout = 0.4 }
autoraise_timer:connect_signal("timeout", function()
  autoraise_timer:stop()
  pcall(function ()  if (autoraise_target and autoraise_target.focusable and autoraise_target.class ~= 'Xfce4-panel') then autoraise_target:raise() end end)
  autoraise_target = nil
end)
client.connect_signal("mouse::enter", function(c)
  if not (c.ontop) then
    autoraise_target = c
    autoraise_timer:again()
  end
end)
client.connect_signal("mouse::leave", function(c)
  autoraise_timer:stop()
  if autoraise_target ~= nil then autoraise_target = nil end
end)
