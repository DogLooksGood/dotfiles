" ===============================================================================
"  Initialization: No compatible and set up runtimepath & python path.
" ===============================================================================

if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

syntax enable 
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" ================================================================================
"  Plugins: Manage plugins with `neobundle`
" $ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
" $ sh ./install.sh
" ================================================================================
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" --------------------------------------------------------------------------------
"  Edit:
" --------------------------------------------------------------------------------
NeoBundle 'Raimondi/delimitMate'                   " parentheses auto complete
NeoBundle 'easymotion/vim-easymotion'              " Ace Jump e.g. <SPC><SPC>x
NeoBundle 'goldfeld/vim-seek'                      " Seek next two char  e.g. ,ee
NeoBundle 'tpope/vim-speeddating'                  " Number inc/dec e.g. <C-a> | <C-x> on number
NeoBundle 'terryma/vim-multiple-cursors'           " Multiple cursor e.g. In visual mode, <C-n> | <C-x> | <C-p>
NeoBundle 'terryma/vim-expand-region'              " e.g. In visual mode, v
NeoBundle 'scrooloose/nerdcommenter'               " Commenter e.g. <SPC>cl | <SPC>cu
NeoBundle 'maxbrunsfeld/vim-emacs-bindings'        " Unix cursove movement
NeoBundle 'tpope/vim-surround'                     " Surrend region with specify symbol. e.g. <SPC>[ | <SPC>] | <SPC>( | <SPC>) etc
NeoBundle 'dhruvasagar/vim-table-mode'             " Toggle with <SPC>tm
NeoBundle 'pelodelfuego/vim-swoop'                 " Multiple find & modify e.g. <SPC>l
NeoBundle 'junegunn/vim-easy-align'                " Align text , TODO
"NeoBundle 'bhurlow/vim-parinfer'

" --------------------------------------------------------------------------------
"  Syntax:
" --------------------------------------------------------------------------------
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'Glench/Vim-Jinja2-Syntax'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'wting/rust.vim'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'dag/vim-fish'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'jceb/vim-orgmode'

" --------------------------------------------------------------------------------
"  File:
" --------------------------------------------------------------------------------
NeoBundle 'majutsushi/tagbar'          " <SPC>r
NeoBundle 'scrooloose/nerdtree'        " <SPC>0
NeoBundle 'kien/ctrlp.vim'             " Swith to file in project. <SPC>f , Swith to opened buffer. <SPC>b, Most used. <SPC>B
NeoBundle 'rking/ag.vim'
NeoBundle 'danro/rename.vim'           " Unused!
NeoBundle 'jlanzarotta/bufexplorer'    " Unused!
" --------------------------------------------------------------------------------
"  Version_control:
" --------------------------------------------------------------------------------
NeoBundle 'tpope/vim-fugitive'         " Git

" --------------------------------------------------------------------------------
"  Process_interaction:
" --------------------------------------------------------------------------------
NeoBundle 'epeli/slimux'                     " Send to Tmux e.g. Config with <SPC>sc, Send region <SPC>ss, Send line <SPC>sl
NeoBundle 'christoomey/vim-tmux-navigator'   " <M-l> <M-r> <M-j> <M-k>

" --------------------------------------------------------------------------------
"  Template_and_completion:
" --------------------------------------------------------------------------------
NeoBundle 'honza/vim-snippets'               " Template complete. e.g. <C-l>
NeoBundle 'SirVer/ultisnips'
NeoBundle 'ervandew/supertab'                " TAB Complete
NeoBundle 'mattn/emmet-vim'                  " HTML e.g. <C-j>
NeoBundle 'artur-shaik/vim-javacomplete2'

" --------------------------------------------------------------------------------
"  Theme:
" --------------------------------------------------------------------------------
NeoBundle 'endel/vim-github-colorscheme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'spinningarrow/vim-niji'           " Rainbow parentheses
NeoBundle 'bling/vim-airline'
NeoBundle 'DogLooksGood/zoomwin-vim'         " Unused!

" --------------------------------------------------------------------------------
"  Others:
" --------------------------------------------------------------------------------
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\    },
\ }
NeoBundle 'Shougo/unite.vim'                 " <C-u>
NeoBundle 'mtth/scratch.vim'                 " Open a scratch buffer, e.g. gs
NeoBundle 'moll/vim-bbye'
NeoBundle 'szw/vim-maximizer'

" NeoBundle 'tpope/vim-fireplace'
" NeoBundle 'tpope/vim-salve'

" Finish
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" ================================================================================
"  Configurations:
" ================================================================================

" --------------------------------------------------------------------------------
"  Basic:
" --------------------------------------------------------------------------------
syntax on
" ttyfast
set ttyfast
" xterm-256color
"set t_Co=256
" enable line number
set nu
"set bufhidden=delete
set completeopt-=preview

" --------------------------------------------------------------------------------
"  Theme:
" --------------------------------------------------------------------------------
" colorscheme solarized
" colorscheme github

set background=dark
" set cursorline
set laststatus=2
set noshowmode
set noshowcmd
set wildmode=longest,list,full
set wildmenu

let g:airline#extensions#whitespace#checks = []
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_theme = "raven"

hi! VertSplit ctermfg=NONE ctermbg=NONE cterm=NONE term=NONE
" --------------------------------------------------------------------------------
"  Space_leader: Use space as leader key
" --------------------------------------------------------------------------------
nmap <Space> <NOP>
let mapleader="\<Space>"

" --------------------------------------------------------------------------------
"  Syntax:
" --------------------------------------------------------------------------------
" Indent with 4 spaces instead of tab
set ts=4
set sws=4
set sw=4
set expandtab
" No auto fold
set foldmethod=manual

" Rainbow parentheses
let g:rbpt_max = 32
let g:rbpt_loadcmd_toggle = 0
" Clojure line commend use ;;
let g:NERDCustomDelimiters = {
				\ 'clojure': { 'left': ';; ' }
			\ }
let g:jsx_ext_required = 0

" Use 2 spaces indentation in web
au FileType javascript,html,json,javascript.jsx,coffee,sass setlocal ts=2 sts=2 sw=2
" Python doc string support
au FileType python let b:delimitMate_nesting_quotes = ['"']
" Clojure use ' for quote
au FileType clojure let b:delimitMate_quotes="\""
" Treat es6 as jsx
au BufNewFile,BufRead *.es6 set filetype=javascript.jsx
" .fishrc
au BufNewFile,BufRead .fishrc set filetype=fish

" --------------------------------------------------------------------------------
"  File: 
" --------------------------------------------------------------------------------
" Wild ignore file extensions
set wildignore+=*/tmp/*,*/dist/*,*/node_modules/*,*/log/*,*/target/*,*/out/*,*/android/*,*/ios/*
set wildignore+=*.pyc,*.bak,*~,*.swp

" NERDTree ignore
let NERDTreeIgnore=['\.swp$', '\~$', '\.pyco$', 'node_modules', 'dist']

" --------------------------------------------------------------------------------
"  Send_to_terminal:
" --------------------------------------------------------------------------------
function! IfTerminalSetId()
    if exists("b:terminal_job_id")
        let g:last_terminal_job_id = b:terminal_job_id
    endif
endfunction

augroup Terminal
  au!
  au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
  au BufEnter * call IfTerminalSetId()
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

" --------------------------------------------------------------------------------
"  Emmet:
" --------------------------------------------------------------------------------
let g:user_emmet_mode = 'in'

" --------------------------------------------------------------------------------
"  Supertab:
" --------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-p>"

" --------------------------------------------------------------------------------
"  Paredit:
" --------------------------------------------------------------------------------
let g:paredit_electric_return = 0

" --------------------------------------------------------------------------------
"  Slimux:
" --------------------------------------------------------------------------------
let g:slimux_select_from_current_window = 1

" --------------------------------------------------------------------------------
"  CtrlP:
" --------------------------------------------------------------------------------
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>'],
  \ 'PrtSelectMove("k")':   ['<c-p>'],
  \ 'PrtHistory(-1)':       ['<up>'],
  \ 'PrtHistory(1)':        ['<down>']
  \ }

" --------------------------------------------------------------------------------
"  Scratch:
" --------------------------------------------------------------------------------
let g:scratch_horizontal = 1
let g:scratch_insert_autohide = 0
let g:scratch_top = 1


" --------------------------------------------------------------------------------
"  BufExplorer:
" --------------------------------------------------------------------------------
let g:bufExplorerDisableDefaultKeyMapping = 1

" --------------------------------------------------------------------------------
"  Dwm:
" --------------------------------------------------------------------------------
let g:dwm_map_keys = 0

" --------------------------------------------------------------------------------
"  JavaComplete2:
" --------------------------------------------------------------------------------
au FileType java setlocal omnifunc=javacomplete#Complete
au FileType java let b:SuperTabDefaultCompletionType = "<c-x><c-o><c-p>"

" ================================================================================
"  Keybindings:
" ================================================================================
" | prefix key | command      |
" |------------+--------------|
" | g          | Git          |
" | t          | Toggle & Tab |
" | s          | Slime        |
" | u          | Unite        |
" | k          | Kill Buffer  |
" | c          | Comment      |
" | f          | Find File    |
" | b          | Find Buffer  |
" | l          | Tag List     |
" | 0          | Tree View    |

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:SeekKey=','

imap <M-Return> <C-x><C-o>
vmap <silent> <Leader>} S}
vmap <silent> <Leader>{ S{
vmap <silent> <Leader>] S]
vmap <silent> <Leader>[ S[
vmap <silent> <Leader>) S)
vmap <silent> <Leader>( S(
vmap <silent> <Leader>" S"
vmap <silent> <Leader>' S'
vmap <silent> <Leader>` S`
nnoremap <return> o<esc>
nnoremap <silent> <leader>tr :set rnu!<cr>
nnoremap <silent> <leader>tp :set paste!<cr>
nnoremap <silent> <leader>tm :TableModeToggle<cr>
nnoremap <silent> <leader>R :source ~/.nvimrc<cr>
nnoremap <silent> <leader>0 :NERDTreeToggle<cr>
nnoremap <silent> <leader>r :TagbarOpenAutoClose<cr>
nnoremap <Leader>f :CtrlP<cr>
nnoremap <Leader>b :CtrlPBuffer<cr>
"nnoremap <Leader>b :ToggleBufExplorer<cr>
nnoremap <Leader>B :CtrlPMixed<cr>
imap <C-J> <Plug>(emmet-expand-abbr)
vnoremap <Leader>ss :SlimuxREPLSendSelection<cr>
nnoremap <Leader>sl :SlimuxREPLSendLine<cr>
nnoremap <Leader>sc :SlimuxREPLConfigure<cr>
nnoremap <silent> <Leader>q :Bdelete<cr>
nnoremap <silent> <Leader>Q :Bdelete!<cr>
nnoremap <silent> <Leader>x :terminal! (cd `pwd`; fish)<cr>
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
au FileType * nmap <Leader><Leader> <Plug>(easymotion-s)
nmap <leader>gB :Gblame<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gb :Gbrowse<cr>
nmap <leader>gr :Gread<cr>
nmap <leader>gw :Gwrite<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gm :Gmove<cr>
nmap <leader>gR :Gremove<cr>
nmap <leader>gP :Gpush<cr>
nmap <leader>gf :Gfetch<cr>
nmap <leader>gg :Unite grep/git<cr><cr>
nmap + <Plug>SpeedDatingUp
nmap - <Plug>SpeedDatingDown
nnoremap <silent> <leader>u :Unite<cr>
nmap <Leader>l :call Swoop()<cr>
vmap <Leader>l :call SwoopSelection()<cr>

let g:python_host_prog = '/usr/local/bin/python'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" Not use terminal, tmux instead.
"tnoremap <Esc> <C-\><C-n>
"tnoremap <A-h> <C-\><C-n><C-w>h
"tnoremap <A-j> <C-\><C-n><C-w>j
"tnoremap <A-k> <C-\><C-n><C-w>k
"tnoremap <A-l> <C-\><C-n><C-w>l
"nnoremap <A-v> <C-w>v
"nnoremap <A-s> <C-w>s
"nmap <A-o> <C-w>o
"nnoremap <A-c> <C-w>c
"nmap <A-n> gt
"nmap <A-p> gt
"nmap <A-w> :tabclose<cr>
"nmap <A-t> :tabnew<cr>
"nmap <A-x> :tabnew<cr>:terminal! (cd `pwd`; fish)<cr>
"nnoremap <silent> <Leader>el :REPLSendLine<cr>
"vnoremap <silent> <leader>es :REPLSendVisual<cr>
