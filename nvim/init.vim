" default indentation
set ts=4 sts=4 sw=4 expandtab

filetype plugin indent on
syntax on
set number
set relativenumber
set linebreak
set nohls
set hidden
set noerrorbells
set incsearch
set updatetime=50 " Default is 4000 ms
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set splitbelow

set nobackup
set noswapfile
set noundofile

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'preservim/nerdtree'

" For Git purposes
Plug 'tpope/vim-fugitive'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
Plug 'tpope/vim-surround'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'L3MON4D3/LuaSnip'

call plug#end()

colorscheme gruvbox
let g:airline_theme='angr'

highlight Normal guibg=none
set listchars=tab:❯\ ,eol:¬

command! Config execute ":e $MYVIMRC"

let mapleader = " "

inoremap jk <Esc>
inoremap uu <Esc>:update<cr>

nnoremap <silent> <Leader>c :bp<BAR>bd#<CR>
nnoremap <Leader>nt :NERDTreeToggle<Enter> " Nerdtree Toggle
nnoremap <Leader>nf :NERDTreeFind<CR> " Nerdtree Find
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

tnoremap kj <C-\><C-n>

" command Term :split term://zsh

if has("autocmd")
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    
    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

source ~/.config/nvim/plug-config/lsp-config.vim

lua << EOF
require('lsp.python-ls')
require('plugins.compe-config')
EOF

