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
Plugin 'Townk/vim-autoclose'
Plugin 'altercation/vim-colors-solarized'
Plugin 'mtth/scratch.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/VimClojure'
Plugin 'oblitum/rainbow'
Plugin 'ervandew/supertab'
Plugin 'maxbrunsfeld/vim-emacs-bindings'
Plugin 'jpalardy/vim-slime'
Plugin 'derekwyatt/vim-scala'
Plugin 'mattn/emmet-vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'itchyny/lightline.vim'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'terryma/vim-expand-region'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
filetype plugin indent on

set t_Co=256
set noshowmode
set nu
set ruler
set ts=4
set sws=4
set sw=4
set expandtab
set smartindent
set cursorline
set laststatus=2
set esckeys
colorscheme solarized
set background=dark

syntax enable
filetype plugin indent on

" paste
set clipboard=unnamed

" Set Leader key to <Space>
nnoremap <Space> <NOP>
let mapleader = "\<Space>"

" Use FD to escape
set timeout timeoutlen=5000 ttimeoutlen=50
set <F13>=fd
imap <F13> <C-c>
set <F14>=df
imap <F14> <C-c>

" Shortcut [FILE]
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fr :source ~/.vimrc<CR>

" Shortcut [QUIT]
nnoremap <Leader>qq :q!<CR>

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
nnoremap <Leader>ts :Scratch<CR>

" CtrlP
nnoremap <Leader>p :CtrlP<CR>
nmap <C-p> <NOP>

" Shortcut [SLIME]
xmap <Leader>ss <Plug>SlimeRegionSend
nmap <Leader>ss <Plug>SlimeParagraphSend
nmap <Leader>sc <Plug>SlimeConfig

" Shortcut [ALIGN]
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a<Space> :Tabularize /<Space>\zs<CR>
vmap <Leader>a<Space> :Tabularize /<Space>\zs<CR>

" Slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_python_ipython = 1

" Emment
let g:user_emmet_mode='i'

" Expant Region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" autocmd
au FileType lisp,clojure let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "'")
au FileType clojure,python call rainbow#load()

" Shortcut [EASYMOTION]
" Must use autocmd
au FileType * nmap <Leader><Leader> <Plug>(easymotion-s)

" Emacs Key Binding
inoremap <C-n> <Down>
inoremap <C-p> <Up>

" Lightline
let g:lightline = {'colorscheme': 'solarized'}

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <Esc>l :TmuxNavigateLeft<cr>
nnoremap <silent> <Esc>j :TmuxNavigateDown<cr>
nnoremap <silent> <Esc>k :TmuxNavigateUp<cr>
nnoremap <silent> <Esc>l :TmuxNavigateRight<cr>
nnoremap <silent> <Esc>\ :TmuxNavigatePrevious<cr>
