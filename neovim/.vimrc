set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath


"  ____                           _
"  / ___| ___ _ __   ___ _ __ __ _| |
"  | |  _ / _ \ '_ \ / _ \ '__/ _` | |
"  | |_| |  __/ | | |  __/ | | (_| | |
"  \____|\___|_| |_|\___|_|  \__,_|_|
"

set nocompatible               " disable compatibility to old-time vi
set showmatch                  " Show matching brackets when text indicator is over them
set ignorecase                 " case insensitive
set smartcase
set mouse=a                    " middle-click paste with
set noshowmode
set noshowcmd 

set hlsearch                   " highlight search
set incsearch                  " incremental search

set tabstop=4                  " number of columns occupied by a tab
set softtabstop=4              " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                  " converts tabs to white space
set shiftwidth=4               " width for autoindents

set autoindent                 " indent a new line the same amount as the line just typed
set smartindent

set number                     " add line numbers
set relativenumber

set wildmenu
set wildoptions=fuzzy 
set wildmode=longest,full,full " get bash-like tab completions
filetype plugin indent on      " allow auto-indenting depending on file type
syntax on                      " syntax highlighting
set mouse=a                    " enable mouse click
filetype plugin on
set ttyfast                    " Speed up scrolling in Vim

set nowb
set noerrorbells               " No annoying sound on errors
set novisualbell               " No annoying sound on errors
set breakindent

set undofile  " Enable persistent undo
set undodir=~/.vim/undod
set noswapfile                 " disable creating swap file
set nobackup                   " Turn backup off, since most stuff is in SVN, git et.c anyway...

set signcolumn=yes 
set scrolloff=8


set fillchars+=diff:╱
set fillchars+=vert:│


set statusline=%#MyLine#%{repeat('─',winwidth('.'))}%*
set pumheight=15
let g:netrw_banner=0


set updatetime=50
set timeoutlen=300
set ttimeout
set ttimeoutlen=0
set timeout

set splitright
set splitbelow 

set hidden
set history=10000
" set termguicolors
set laststatus=0
set encoding=utf8              " Set utf8 as standard encoding and en_US as the standard language
"  set spell                      " enable spell check (may need to download language package)
"  set ffs=unix,dos,mac           " Use Unix as the standard file type

set backspace=eol,start,indent " Configure backspace so it acts as it should act
set previewheight=5
set mat=2 " How many tenths of a second to blink when matching brackets
set t_vb=
set tm=500
set viminfo^=%                  " Remember info about open buffers on close

set termguicolors
"  _  __
"  | |/ /___ _   _ _ __ ___   __ _ _ __  ___
"  | ' // _ \ | | | '_ ` _ \ / _` | '_ \/ __|
"  | . \  __/ |_| | | | | | | (_| | |_) \__ \
"  |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
"            |___/                |_|
"


let mapleader = " "

" Move cursor to left and right pane with Ctrl+L and Ctrl+H
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-Left> :call win_move_separator(winnr('h'), -2)<CR>
nnoremap <C-Right> :call win_move_separator(winnr('h'), 2)<CR>
nnoremap <C-Up> :call win_move_statusline(winnr('k'), -2)<CR>
nnoremap <C-Down> :call win_move_statusline(winnr('k'), 2)<CR>

nnoremap <Leader> <Nop> 
vnoremap <Leader> <Nop> 
nnoremap - :Ex<CR>
nnoremap <silent> <Leader><Leader> :b#<CR> 
nnoremap <ESC> :noh<CR> 

nnoremap <Leader>p "0p
xnoremap <Leader>p "0p

nnoremap <Leader>y "+y
xnoremap <Leader>y "+y

nnoremap <C-f> :silent !tmux neww tmux-sessionizer<CR>

nnoremap <A-j> :cnext<CR>
nnoremap <A-k> :cprev<CR>

vnoremap <Up> :m '<-2<CR>gv=gv 
vnoremap <Down> :m '>+1<CR>gv=gv
nnoremap <Leader>z :tabclose<CR>

nnoremap <silent> <Leader>gs :G<CR>


"      _         _                                                      _     
"     / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___ 
"    / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
"   / ___ \ |_| | || (_) | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
"  /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
"                                                                             
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
" augroup myCmds
" au!
" autocmd VimEnter * silent !echo -ne "\e[2 q"
" augroup END



packadd! matchit
call plug#begin()
" Using a non-default branch
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

Plug 'machakann/vim-highlightedyank'
" Use 'dir' option to install plugin in a non-default directory
" Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

call plug#end()

colorscheme catppuccin_mocha
highlight link MyLine VertSplit

if !exists('##TextYankPost')
  nmap y <Plug>(highlightedyank)
  xmap y <Plug>(highlightedyank)
  omap y <Plug>(highlightedyank)
endif

let g:highlightedyank_highlight_duration = 200 

nnoremap <C-P> :FZF<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

