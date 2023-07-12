local xresources = require("beautiful.xresources")
local table = require "table"
local io = require "io"

local dpi = xresources.apply_dpi

local path = os.getenv("HOME") .. "/.cache/wal/colors"
local file = io.open(path, "r")

local colors = {}

if file then
  for line in file:lines() do
    local color = line:match("^%s*(.-)%s*$")
    table.insert(colors, color)
  end
  file:close()
else
  print("Failed to open the file.")
end

local theme = {}

theme.font          = "JetBrainsMono 10"

theme.bg_normal     = colors[1]
theme.bg_focus      = colors[2]
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = colors[1]

theme.tasklist_bg_normal = colors[1]
theme.tasklist_bg_focus = colors[1]

theme.titlebar_bg_focus = colors[1]

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_focus  = theme.border_normal

return theme
