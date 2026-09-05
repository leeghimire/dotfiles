-- Options -------------------------------------------------------------------
vim.g.mapleader = " "

-- Use the terminal's own 16-colour palette so ghostty's theme (and its
-- light/dark choice) drives everything. 'background' is detected at startup.
vim.o.termguicolors = false

vim.o.laststatus = 3
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.wrap = false

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

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
-- Parsers come from nvim-treesitter.withPlugins in home.nix.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Plugins (installed by home-manager, see home.nix) ------------------------
-- blink.cmp defaults: <C-n>/<C-p> move, <C-y> accept, <C-e> close,
-- <C-space> show/docs, <C-b>/<C-f> scroll docs, <Tab>/<S-Tab> snippet jumps.
require("blink.cmp").setup({})

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
