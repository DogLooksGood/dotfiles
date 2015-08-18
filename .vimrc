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
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'mtth/scratch.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'maxbrunsfeld/vim-emacs-bindings'
Plugin 'jpalardy/vim-slime'
Plugin 'derekwyatt/vim-scala'
Plugin 'mattn/emmet-vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'terryma/vim-expand-region'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'guns/vim-clojure-static'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'wting/rust.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-surround'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'rking/ag.vim'
Plugin 'kchmck/vim-coffee-script'

call vundle#end()
syntax on
filetype plugin indent on
set t_Co=256
set noshowmode
set nu
set ruler
set ts=4
set sts=4
set sw=4
set expandtab
set smartindent
set cursorline
set laststatus=2
set nofoldenable
colorscheme solarized
"colorscheme tomorrow-night-bright
set background=dark

" paste
set clipboard=unnamed
set pastetoggle=<F5>

" Set Leader key to <Space>
nmap <Space> <NOP>
let mapleader="\<Space>"

" Fast escape
if ! has('gui_running')
  set ttimeoutlen=100
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=500
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Shortcut [FILE]
nnoremap <Leader>fw :w<CR>
nnoremap <Leader>fr :source ~/.vimrc<CR>
nnoremap <silent> <Leader>fs :source %<CR>

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


" Expant Region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" autocmd
" au FileType lisp,clojure let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "'")

" Shortcut [EASYMOTION]
" Must use autocmd
au FileType * nmap <Leader><Leader> <Plug>(easymotion-s)
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au FileType javascript,html,json,javascript.jsx,coffee setlocal ts=2 sts=2 sw=2

" Emacs Key Binding
inoremap <C-n> <Down>
inoremap <C-p> <Up>

" Lightline
let g:lightline = {'colorscheme': 'solarized'}

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Shortcut [VIM]
nnoremap <Leader>vi :PluginInstall<CR>
nnoremap <Leader>vc :PluginClean<CR>

" Rainbow
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 30
let g:rbpt_loadcmd_toggle = 0
" JSX
let g:jsx_ext_required = 0

" Emment
let g:user_emmet_mode='in'
let g:user_emmet_leader_key='<C-Y>'

nmap \ :b#<CR>
