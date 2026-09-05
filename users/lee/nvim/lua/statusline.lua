-- Statusline, adapted from lualine's "evil_lualine" example:
--   https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
--   Author: shadmansaleh, credit: glepnir (MIT, same as lualine).
-- Changes from the original: colours are terminal palette indexes instead of
-- fixed hex values so the bar follows the terminal theme, the OS logo is
-- replaced by a mode-coloured bar, and it uses the Nvim 0.11+ LSP API.
local lualine = require("lualine")

-- Terminal palette: 0-7 normal, 8-15 bright. Names kept from the original.
local colors = {
  red = 1,
  green = 2,
  yellow = 3,
  blue = 4,
  magenta = 5,
  cyan = 6,
  orange = 9,
  violet = 13,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

local mode_color = {
  n = colors.red,
  i = colors.green,
  v = colors.blue,
  ["\22"] = colors.blue,
  V = colors.blue,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  ["\19"] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.red,
}

-- No background: the bar sits directly on the terminal's background.
local transparent = { c = { fg = "NONE", bg = "NONE" } }

local config = {
  options = {
    component_separators = "",
    section_separators = "",
    theme = { normal = transparent, inactive = transparent },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    return "▊"
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()] or colors.blue }
  end,
  padding = { left = 0, right = 1 },
})

ins_left({ "filesize", cond = conditions.buffer_not_empty })

ins_left({
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = "bold" },
})

ins_left({ "location" })
ins_left({ "progress", color = { gui = "bold" } })

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
    hint = { fg = colors.cyan },
  },
})

ins_left({
  function()
    return "%="
  end,
})

ins_left({
  function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
      return "No Active Lsp"
    end
    return clients[1].name
  end,
  icon = " LSP:",
  color = { gui = "bold" },
})

ins_right({
  "o:encoding",
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = "bold" },
})

ins_right({
  "fileformat",
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, gui = "bold" },
})

ins_right({
  "branch",
  icon = "",
  color = { fg = colors.violet, gui = "bold" },
})

ins_right({
  "diff",
  symbols = { added = " ", modified = "󰝤 ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})

ins_right({
  function()
    return "▊"
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
})

lualine.setup(config)
