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

set nobackup
set noswapfile
set noundofile

call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'
Plug 'nvim-telescope/telescope.nvim'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
" Better powerline/status bar at the bottom
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'

" Manage multiple buffers
Plug 'qpkorr/vim-bufkill'

" Extended tags for HTML
Plug 'https://github.com/adelarsq/vim-matchit'

" Prettier for vue projects etc
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" For Git purposes
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

call plug#end()

" search first in current directory then file directory for tag file
set tags=tags,./tags

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

colorscheme gruvbox
highlight Normal guibg=none
set listchars=tab:❯\ ,eol:¬

command! Config execute ":e $MYVIMRC"

let mapleader = " "
inoremap jk <Esc>
inoremap uu <Esc>:update<cr>
nnoremap <silent> <Leader>c :bp<BAR>bd#<CR>

nnoremap <Leader>nt :NERDTreeToggle<Enter> " Nerdtree Toggle
nnoremap <Leader>nf :NERDTreeFind<CR> " Nerdtree Find

:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>

nmap <silent> gd <Plug>(coc-definition)

if has("autocmd")
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    
    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

    " Disable coc for markdown files
    " autocmd FileType markdown :call CocDisable()
command! -nargs=0 Prettier :CocCommand prettier.formatFile 
autocmd bufwritepost .vimrc source $MYVIMRC

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
