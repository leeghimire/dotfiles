return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("clangd")
      vim.lsp.enable("gopls")
      vim.lsp.enable("lua-language-server")
      vim.lsp.enable("pyright")
      vim.lsp.enable("vtsls")
      vim.lsp.enable("zls")

      vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, {})
    end,
  },
}
