set autoread
set hidden
set ignorecase
set nowrap
set nu rnu
set smartcase
set smartindent
set colorcolumn=80
set shiftwidth=4
set scrolloff=8
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

function! RunFile(command) abort
    exec 'new'
    exec 'term ' . a:command
    exec 'setlocal nornu nonu'
    exec 'startinsert'
    autocmd BufEnter <buffer> startinsert
endfunction

autocmd Filetype c	nmap <leader>kk :call RunFile(printf('gcc %s -o a.out && time ./a.out', expand('%')))<CR><CR>
autocmd Filetype cpp	nmap <leader>kk :call RunFile(printf('g++ -std=c++20 %s && time ./a.out', expand('%')))<CR><CR>
autocmd Filetype go	nmap <leader>kk :call RunFile(printf('go build -o a.out %s && time ./a.out', expand('%')))<CR>
autocmd Filetype lua	nmap <leader>kk :call RunFile(printf('time lua %s', expand('%')))<CR>
autocmd Filetype python	nmap <leader>kk :call RunFile(printf('time python3 %s', expand('%')))<CR><CR>
autocmd Filetype rust	nmap <leader>kk :call RunFile(printf('rustc %s -o a.out && time ./a.out', expand('%')))<CR>
nnoremap <leader>kj :%y+<CR>

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : '<TAB>'
nnoremap <leader>rr  <cmd> CocCommand document.renameCurrentWord<CR>
nnoremap <leader>gd <Plug>(coc-definition)

nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope grep_string<cr>
