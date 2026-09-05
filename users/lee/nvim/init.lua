-- Options -------------------------------------------------------------------
vim.g.mapleader = " "

-- Colours come from the terminal: no true colour, and the classic "vim"
-- colorscheme, which is written in terms of the 16 ANSI colours. Neovim maps a
-- few of its colour names onto 256-colour entries when the terminal advertises
-- 256 colours, so those are folded back onto the palette. 'background' is
-- detected from the terminal at startup and the scheme reloads when it changes.
vim.o.termguicolors = false
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "vim",
  callback = function()
    local ansi = { [121] = 10, [81] = 12, [224] = 9, [225] = 13, [159] = 14, [130] = 3, [242] = 8, [248] = 7 }
    for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
      local fg, bg = ansi[hl.ctermfg], ansi[hl.ctermbg]
      if fg or bg then
        hl.ctermfg, hl.ctermbg = fg or hl.ctermfg, bg or hl.ctermbg
        vim.api.nvim_set_hl(0, name, hl)
      end
    end
  end,
})
vim.cmd.colorscheme("vim")

vim.o.laststatus = 3
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.wrap = false

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    vim.bo.shiftwidth = 2 -- nixfmt convention
  end,
})

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.clipboard = "unnamedplus"
vim.o.swapfile = false
vim.o.undofile = true

vim.diagnostic.config({ virtual_text = true })

-- Keymaps -------------------------------------------------------------------
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
vim.keymap.set("n", "<Leader>kj", "ggyG", { desc = "Yank whole file" })

-- LSP -----------------------------------------------------------------------
-- Keymaps are Neovim's defaults (:h lsp-defaults): K grr gri grn gra grt gO,
-- <C-]> for definition, <C-s> in insert mode for signature help.
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("nixd", {
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }",
      },
      options = {
        nixos = {
          expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.rhyolite.options",
        },
        home_manager = {
          expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.rhyolite.options.home-manager.users.type.getSubOptions []",
        },
      },
    },
  },
})

vim.lsp.enable({ "clangd", "gopls", "nixd", "pyright", "vtsls", "rust_analyzer", "zls" })

-- Treesitter ----------------------------------------------------------------
-- Highlighting only. Parsers come from nvim-treesitter.withPlugins in home.nix.
-- Indentation stays with Neovim's runtime indent scripts (treesitter's Nix
-- indent over-indents).
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- Plugins (installed by home-manager, see home.nix) ------------------------
-- blink.cmp: <Tab>/<S-Tab> (or <C-n>/<C-p>) move, <CR> accept, <C-e> close,
-- <C-space> show/docs, <C-b>/<C-f> scroll docs. Nothing is preselected, so
-- <CR> on an untouched menu is a plain newline.
require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
  completion = { list = { selection = { preselect = false } } },
})

require("oil").setup({
  columns = { "icon", "permissions", "size", "mtime" },
  view_options = { show_hidden = true },
  default_file_explorer = true,
  skip_confirm_for_simple_edits = true,
})
vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" })

-- Keymaps as recommended in the telescope README.
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

require("statusline")
