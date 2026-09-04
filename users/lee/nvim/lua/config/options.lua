vim.opt.background = "light"
vim.opt.colorcolumn = "78"
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.clipboard = "unnamedplus"
vim.opt.formatoptions:append("t")
vim.opt.swapfile = false
vim.opt.textwidth = 78

vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
]])

vim.diagnostic.config({ virtual_text = true })
