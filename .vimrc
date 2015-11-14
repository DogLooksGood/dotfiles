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
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'vim-scripts/paredit.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'artur-shaik/vim-javacomplete2'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'derekwyatt/vim-scala'
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
NeoBundle 'mxw/vim-jsx'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'epeli/slimux'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'ervandew/supertab'
NeoBundle 'goldfeld/vim-seek'
NeoBundle 'dag/vim-fish'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\    },
\ }
" NeoBundle 'tpope/vim-vinegar'
" NeoBundle 'jceb/vim-orgmode'

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
set rnu
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
" nmap <silent> \ :b#<CR>
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
inoremap <C-n> <Down>
inoremap <C-p> <Up>
nnoremap <Return> o<Esc>

" TmuxNavigate
nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>


" Expant Region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

let g:rbpt_max = 32
let g:rbpt_loadcmd_toggle = 0
let g:jsx_ext_required = 0
let g:user_emmet_mode='in'
" let g:user_emmet_leader_key='<C-Y>'
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
let g:airline#extensions#whitespace#checks = []

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
vnoremap <Leader>sS :SlimuxREPLSendSelection<CR>
nnoremap <Leader>sL :SlimuxREPLSendLine<CR>
nnoremap <Leader>sC :SlimuxREPLConfigure<CR>
let g:slimux_select_from_current_window = 0

let g:python_host_prog = '/usr/local/bin/python'

autocmd FileType java set omnifunc=javacomplete#Complete

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l
nnoremap <A-v> <C-w>v
nnoremap <A-s> <C-w>s
nnoremap <A-o> <C-w>o
nnoremap <A-c> <C-w>c

" Send command to terminal.
augroup Terminal
  au!
  au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
augroup END

function! REPLSend(lines)
  call jobsend(g:last_terminal_job_id, add(a:lines, ''))
endfunction

function! GetVisual() range
    let reg_save = getreg('"')
    let regtype_save = getregtype('"')
    let cb_save = &clipboard
    set clipboard&

    silent normal! ""gvy
    let selection = getreg('"')

    call setreg('"', reg_save, regtype_save)
    let &clipboard = cb_save
    return selection
endfunction

command! -range=% -bar -nargs=* REPLSendVisual call REPLSend(split(GetVisual(), "\n"))
command! REPLSendLine call REPLSend([getline('.')])

nnoremap <silent> <Leader>sl :REPLSendLine<cr>
vnoremap <silent> <Leader>ss :REPLSendVisual<cr>

nmap <silent> <Leader>k :bd!<cr>
nmap <silent> <A-t> :terminal fish<CR>
nmap <silent> \ <Space>b<CR><CR>
set virtualedit="onemore"

