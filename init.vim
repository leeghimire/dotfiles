set autoread
set hidden
set ignorecase
set nowrap
set nu rnu
set smartcase
set smartindent

set colorcolumn=80
set scrolloff=10
set shiftwidth=4

set clipboard=unnamedplus

call plug#begin('~/.vim/plugged')
    Plug 'dylanaraps/wal.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()

colorscheme wal
hi CocInlayHint ctermfg=darkgray
hi clear StatusLine

let mapleader = ' '

inoremap <silent><expr><TAB> coc#pum#visible() ? coc#pum#confirm() : '<TAB>'
nmap <leader>c <Plug>(coc-codeaction-cursor)
nmap <leader>rn <cmd>CocCommand document.renameCurrentWord<CR>
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)
nnoremap <leader><silent>a  :<C-u>CocList diagnostics<cr>

nnoremap <leader><silent>fb <cmd>Telescope buffers<cr>
nnoremap <leader><silent>ff <cmd>Telescope find_files<cr>
nnoremap <leader><silent>fg <cmd>Telescope grep_string<cr>
