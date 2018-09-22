-- Standard awesome library
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local autofocus = require("awful.autofocus")

local handle_errors = false
if (handle_errors) then
  local naughty   = require("naughty")
  -- {{{ Error handling
  -- Check if awesome encountered an error during startup and fell back to
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
                           text = tostring(err) })
          in_error = false
      end)
  end
  -- }}}
end

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Exceptions for Mate stuff
close_exceptions = { "Mate-panel"}
minimize_exceptions = { "Mate-panel"}
autoraise_exceptions = { "Mate-panel"}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
awful.screen.connect_for_each_screen(function(s)
--    screen[s].padding = {left=0,top=0,right=0,bottom=28}
--    screen[s].workarea = {x=0,y=0,width=1920,height=1052}
    -- Each screen has its own tag table.
    awful.tag({ 1, 2, 3, 4, 5, 6 }, s, awful.layout.layouts[1])
    -- awful.layout.set(awful.layout.suit.tile, awful.tag.find_by_name(s, "1"))
    -- awful.layout.set(awful.layout.suit.tile, awful.tag.find_by_name(s, "2"))
    -- awful.tag.setmwfact(0.75, awful.tag.find_by_name(s, "1"))
    -- awful.tag.setmwfact(0.75, awful.tag.find_by_name(s, "2"))
end)
-- }}}


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
--    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
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
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

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
    awful.key({ modkey,           }, "space", function () awful.layout.inc(1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    -- awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift" }, "m",
        function (c)
          c.maximized = false
          c.maximized_vertical=false
          c.maximized_horizontal=false
          c:raise()
        end ,
    {description = "demaximize", group = "client"}),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      
        function (c) 
          if not awful.util.table.hasitem(close_exceptions, c.class) then 
            c:kill()
          end
        end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.

            if not awful.util.table.hasitem(minimize_exceptions, c.class) then 
              c.minimized = true
            end
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
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { 
        border_width = 0,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen 
      } 
    },
    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},       
    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "dialog" }
      }, properties = { titlebars_enabled = true }
    },
    -- Custom Rules
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Skype" },
      callback = awful.placement.centered },
    { rule = { name = "/usr/lib/firefox/plugin-container" },
      properties = { fullscreen = true, floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { state = "modal" },
      properties = { floating = true, ontop = true },
      callback = awful.placement.centered },
    { rule = { type="dialog" },
      properties = { floating = true, ontop = true },
      callback = awful.placement.centered },
    { rule = { class="Gcr-prompter" },
      properties = { floating = true, ontop = true, titlebars_enabled = true },
      callback = awful.placement.centered },
    { rule = { class = "Update-manager" },
      properties = { floating = true, ontop = true },
      callback = awful.placement.centered },
    { rule = { class = "Mate-notification-daemon" },
      properties = { focusable = false } },
    { rule = { class = "Mate-panel" },
      properties = { focusable = false },
      callback = function( c )
        local move_timer = gears.timer({ timeout = 0.1 })
        move_timer:connect_signal("timeout", function()
          if not (c == nil) then
            awful.placement.bottom_left(c, { honor_workarea = false, honor_padding = false });
          end
          move_timer:stop()
        end)
        move_timer:start()
      end
   },
    { rule = { class = "Tilix" },
      properties = { 
        floating = true, 
        sticky = true,
        maximized = false,
        maximized_vertical = false,
        maximized_horizontal = false
      } 
    },
    { rule = { class = "Clock-applet" },
      properties = { sticky = true, ontop = true },
      callback = function( c )
        local move_timer = gears.timer({ timeout = 0.1 })
        move_timer:connect_signal("timeout", function()
          if not (c == nil) then
            awful.placement.bottom_right(c, { honor_workarea = true, honor_padding = true });
          end
          move_timer:stop()
        end)
        move_timer:start()
      end
    },
    { rule = { name = "x-caja-desktop" },
      properties = { sticky = true, focusable = false } },
    { rule = { class = "TelegramDesktop" },
      properties = { minimized = false } },
}
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    -- c.maximized_vertical = false
    -- c.maximized_horizontal = false
    -- c.floating = false

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal, 
    }
    awful.titlebar(c)
end)

-- {{{ Auto raise
autoraise_target = nil
autoraise_timer = gears.timer{timeout = 0.8}
autoraise_timer:connect_signal("timeout", function()
  -- print('autoraise_timer')
  autoraise_timer:stop()
  pcall(function ()  
    if (
      autoraise_target 
      and autoraise_target.focusable 
      and not awful.util.table.hasitem(autoraise_exceptions, autoraise_target.class)
      ) then 

      autoraise_target:raise() 
    end 
  end)
  autoraise_target = nil
end)

client.connect_signal("mouse::enter", function(c)
  -- print('autoraise_enter')
  if not c.ontop then
    autoraise_target = c
    autoraise_timer:again()
  end
end)

client.connect_signal("mouse::leave", function(c)
  -- print('autoraise_leave')
  if autoraise_timer.started then
    autoraise_timer:stop()
  end
  if autoraise_target ~= nil then 
    autoraise_target = nil 
  end
end)
--- }}}

-- {{{ Mouse-following focus
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)
-- }}}
