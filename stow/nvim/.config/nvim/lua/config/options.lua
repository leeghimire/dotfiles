vim.opt.number = true
vim.opt.textwidth = 78
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.swapfile = false
vim.opt.formatoptions:append("t")
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.laststatus = 3
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.o.colorcolumn = "78"
vim.o.background = "light"

vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
]])

vim.diagnostic.config({ virtual_text = true })
