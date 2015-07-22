set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-multiple-cursors'
" Plugin 'Townk/vim-autoclose'
Plugin 'altercation/vim-colors-solarized'
Plugin 'mtth/scratch.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/VimClojure'
Plugin 'oblitum/rainbow'

call vundle#end()
filetype plugin indent on

set t_Co=256
set nu
set ruler
set ts=4
set sws=4
set sw=4
set expandtab
set smartindent
set laststatus=2
set background=dark
" colorscheme solarized

syntax enable
filetype plugin indent on

" paste
set clipboard=unnamed

" Set Leader key to <Space>
let mapleader = "\<Space>"

" Shortcut [FILE]
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fr :source ~/.vimrc<CR>

" Shortcut [QUIT]
nnoremap <Leader>qq :wq<CR>
nnoremap <Leader>q! :q!<CR>

" Shortcut [WINDOW]
nnoremap <Leader>ws :split<CR>
nnoremap <Leader>wv :vs<CR>
nnoremap <Leader>wo <C-w>o
nnoremap <Leader>wc <C-w>c
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wl <C-w>l
nnoremap <Leader>1 1<C-w><C-w>
nnoremap <Leader>2 2<C-w><C-w>
nnoremap <Leader>3 3<C-w><C-w>
nnoremap <Leader>4 4<C-w><C-w>
nnoremap <Leader>5 5<C-w><C-w>
nnoremap <Leader>6 6<C-w><C-w>
nnoremap <Leader>7 7<C-w><C-w>
nnoremap <Leader>8 8<C-w><C-w>
nnoremap <Leader>9 9<C-w><C-w>

" Shortcut [TOGGLE]
nnoremap <Leader>tt :TagbarOpenAutoClose<CR>
nnoremap <Leader>tn :NERDTreeToggle<CR>

" Emacs Key Binding
inoremap ≈ <C-o>:
inoremap ƒ <C-o>e
inoremap ∫ <C-o>b
inoremap <C-v> <C-o><C-f>
inoremap √ <C-o><C-b>
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o><Space>
inoremap <C-b> <C-o><Backspace>
inoremap <C-n> <C-o>j
inoremap <C-p> <C-o>k
inoremap <C-k> <C-o>d$
inoremap <C-g> <C-o><C-c>
inoremap <C-d> <C-o>x
inoremap <D-s> <C-o>w<CR>

" CtrlP
nnoremap <Leader>p :CtrlP<CR>

au FileType clojure call rainbow#load()
