set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

"
" Getting Started
" 1. Install neovim on PC, usually via package manager.
" 2. Clone neovim config to ~/.config/nvim/init.vim or $LOCALAPPDATA/nvim/init.vim on Windows
" 3. Run :PackerSync to install Plugins
" 4. Optionally symlink this to ~/.vimrc. As this config should still work as a regular .vimrc file.


"  ____                           _
"  / ___| ___ _ __   ___ _ __ __ _| |
"  | |  _ / _ \ '_ \ / _ \ '__/ _` | |
"  | |_| |  __/ | | |  __/ | | (_| | |
"  \____|\___|_| |_|\___|_|  \__,_|_|
"

set nocompatible               " disable compatibility to old-time vi
set showmatch                  " Show matching brackets when text indicator is over them
set ignorecase                 " case insensitive
set mouse=v                    " middle-click paste with
set hlsearch                   " highlight search
set incsearch                  " incremental search
set tabstop=4                  " number of columns occupied by a tab
set softtabstop=4              " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                  " converts tabs to white space
set shiftwidth=4               " width for autoindents
set autoindent                 " indent a new line the same amount as the line just typed
set number                     " add line numbers
set wildmode=longest,list      " get bash-like tab completions
set cc=80                      " set an 80 column border for good coding style
filetype plugin indent on      " allow auto-indenting depending on file type
syntax on                      " syntax highlighting
set mouse=a                    " enable mouse click
set clipboard=unnamedplus      " using system clipboard
filetype plugin on
set cursorline                 " highlight current cursorline
set ttyfast                    " Speed up scrolling in Vim

set noswapfile                 " disable creating swap file
set nobackup                   " Turn backup off, since most stuff is in SVN, git et.c anyway...
set nowb
set noerrorbells               " No annoying sound on errors
set novisualbell               " No annoying sound on errors

"  set encoding=utf8              " Set utf8 as standard encoding and en_US as the standard language
"  set spell                      " enable spell check (may need to download language package)
"  set ffs=unix,dos,mac           " Use Unix as the standard file type

set backspace=eol,start,indent " Configure backspace so it acts as it should act
set previewheight=5
set mat=2 " How many tenths of a second to blink when matching brackets
set t_vb=
set tm=500
set viminfo^=%                  " Remember info about open buffers on close



"  _  __
"  | |/ /___ _   _ _ __ ___   __ _ _ __  ___
"  | ' // _ \ | | | '_ ` _ \ / _` | '_ \/ __|
"  | . \  __/ |_| | | | | | | (_| | |_) \__ \
"  |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
"            |___/                |_|
"

" Discard when using 'd' to delete
nnoremap d "_d
vnoremap d "_d

" Move cursor to left and right pane with Ctrl+L and Ctrl+H
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move up and down to next empty line with Ctrl+J and Ctrl+K
nnoremap <C-J> <S-}>
nnoremap <C-K> <S-{>
map <C-J> <S-}>
map <C-K> <S-{>
map <M-J> <S-}>
map <M-K> <S-{>
noremap <C-J> }
noremap <C-K> {
vnoremap <C-J> }
vnoremap <C-K> {

" Toggle File Explorer with Ctrl+B
map <C-b> :NERDTreeToggle<CR>

