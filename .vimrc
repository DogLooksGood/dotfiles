" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'spinningarrow/vim-niji'
NeoBundle 'vim-scripts/paredit.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'mtth/scratch.vim'
NeoBundle 'maxbrunsfeld/vim-emacs-bindings'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'Glench/Vim-Jinja2-Syntax'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'wting/rust.vim'
NeoBundle 'rking/ag.vim'
"NeoBundle 'honza/vim-snippets'
"NeoBundle 'SirVer/ultisnips'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'myusuf3/numbers.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'goldfeld/vim-seek'
NeoBundle 'dag/vim-fish'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }


" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()
" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

set ttyfast
set t_Co=256
set foldlevelstart=99
set laststatus=2
set mouse=a
syntax on
set nu
set ts=4
set sws=4
set sw=4
set expandtab
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
set noshowmode
set noshowcmd
set cursorline
set pastetoggle=<F5>

" Set Leader key to <Space>
nmap <Space> <NOP>
nmap <silent> \ :b#<CR>
let mapleader="\<Space>"

let g:SeekKey=','

" Shortcuts
nnoremap <silent> <Leader>` :source ~/.vimrc<CR>
nnoremap <silent> <Leader>t :NERDTreeToggle<CR>
nnoremap <silent> <Leader>l :TagbarOpenAutoClose<CR>

" Expant Region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" Emacs Key Binding
"inoremap <C-n> <Down>
"inoremap <C-p> <Up>

" TmuxNavigate
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" Shortcut [SLIME]
xmap <Leader>ss <Plug>SlimeRegionSend
nmap <Leader>ss <Plug>SlimeParagraphSend
nmap <Leader>sc <Plug>SlimeConfig

" Expant Region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" Slime
let g:slime_target = "tmux"
let g:slime_no_mappings = 1
let g:slime_paste_file = tempname()
let g:slime_python_ipython = 1

let g:rbpt_max = 32
let g:rbpt_loadcmd_toggle = 0
let g:jsx_ext_required = 0
let g:user_emmet_mode='in'
let g:user_emmet_leader_key='<C-Y>'
let NERDTreeIgnore=['\.swp$', '\~$', '\.pyco$', 'node_modules', 'dist']

" Fast escape
if ! has('gui_running')
  set ttimeoutlen=100
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=500
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

au FileType * nmap <Leader><Leader> <Plug>(easymotion-s)
au FileType javascript,html,json,javascript.jsx,coffee,sass setlocal ts=2 sts=2 sw=2
au FileType python let b:delimitMate_nesting_quotes = ['"']
au FileType clojure let b:delimitMate_quotes="\""
au BufNewFile,BufRead *.es6 set filetype=javascript.jsx

set wildignore+=*/tmp/*,*/dist/*,*/node_modules/*,*/log/*
set wildignore+=*.pyc,*.bak,*~,*.swp

let g:NERDCustomDelimiters = {
				\ 'clojure': { 'left': ';; ' }
			\ }
let g:UltiSnipsExpandTrigger="<C-l>"
let g:SuperTabDefaultCompletionType = "<c-p>"
imap <C-J> <Plug>(emmet-expand-abbr)

let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:paredit_electric_return=0

nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>B :CtrlPMixed<CR>

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>'],
  \ 'PrtSelectMove("k")':   ['<c-p>'],
  \ 'PrtHistory(-1)':       ['<up>'],
  \ 'PrtHistory(1)':        ['<down>']
  \ }

" Plugin key-mappings.
imap <C-l>     <Plug>(neosnippet_expand_or_jump)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

