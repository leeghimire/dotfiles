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
call plug#end()

colorscheme wal 

hi CocInlayHint ctermfg=darkgray
hi clear StatusLine

let mapleader = ' '

inoremap <silent><expr><TAB> coc#pum#visible() ? coc#pum#confirm() : '<TAB>'

nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>cd  :<C-u>CocList diagnostics<cr>
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)
