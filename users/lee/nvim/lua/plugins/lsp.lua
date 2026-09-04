return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
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

      vim.lsp.enable("clangd")
      vim.lsp.enable("gopls")
      vim.lsp.enable("nixd")
      vim.lsp.enable("pyright")
      vim.lsp.enable("vtsls")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("zls")

      vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, {})
    end,
  },
}
