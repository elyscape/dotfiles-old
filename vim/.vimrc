if has('win32')
  let home=escape($HOME, '\')
  let &rtp = substitute(&rtp, '\V'.home.'/vimfiles', home.'/.vim', 'g')
  unlet home
endif

set viewdir=~/.vim/view

set fo=tcq
set nocompatible
set modeline
set bg=dark
set novisualbell
set encoding=utf-8

if has('win32') && match($PATH, '\cC:\\Program Files (x86)\\Git\\bin\\\?') == -1
  let $PATH .= ';C:\Program Files (x86)\Git\bin\'
endif

call plug#begin('~/.vim/bundle')

Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elyscape/vim-winjumplist'
Plug 'freeo/vim-kalisi'
Plug 'godlygeek/tabular'
Plug 'kchmck/vim-coffee-script'
Plug 'mbbill/undotree'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/clever-f.vim'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/restore_view.vim'

call plug#end()

nmap <Leader>pu :PlugUpdate<CR>
nmap <Leader>pg :PlugUpgrade<CR>

if empty(glob('~/.vim/bundle/*'))
  aug InstallPlug
    au!
    au VimEnter * PlugInstall
    au VimEnter * source $MYVIMRC
  aug END
  finish
endif

set omnifunc=syntaxcomplete#Complete
au FileType css setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType python setlocal omnifunc=pythoncomplete#Complete
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType ruby setlocal omnifunc=rubycomplete#Complete

highlight comment ctermfg=cyan

set tabstop=2
set expandtab
set softtabstop=-1
set shiftwidth=2

set selection=exclusive
set selectmode=mouse,key
set keymodel=startsel

if has('gui_running')
  set guioptions-=T   " disable toolbar
  set bg=light
  colorscheme kalisi
  set lines=40 columns=108 linespace=0
  if has('gui_win32')
    set guifont=Consolas_for_Powerline:h10:cANSI
    let s:heights=split(system("wmic path Win32_VideoController get CurrentVerticalResolution /value | sed '/=/!d'"))
    for height in s:heights
      if height[26:] != '' && height[26:] >= 1000
        set guifont=Consolas_for_Powerline:h11:cANSI
      endif
    endfor
    let s:symbols=1
    if has('directx')
      set renderoptions=type:directx,taamode:0,renmode:0
    endif
  endif
  if has('gui_macvim')
    set guifont=Consolas\ for\ Powerline:h11
    let s:symbols=1
  endif
  if exists('s:symbols')
    let g:airline_symbols = {}
    let g:airline_left_sep = "\u2b80"
    let g:airline_left_alt_sep = "\u2b81"
    let g:airline_right_sep = "\u2b82"
    let g:airline_right_alt_sep = "\u2b83"
    let g:airline_symbols.branch = "\u2b60"
    let g:airline_symbols.readonly = "\u2b64"
    let g:airline_symbols.linenr = "\u2b61"
  endif
endif

" enable 256 colors in ConEmu on Windows
if has('win32') && !has('gui_running') && $ConEmuANSI == 'ON'
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif

if &t_Co == 256
  colors kalisi
endif

highlight MixedTabs ctermbg=darkgreen guibg=darkgreen
call matchadd('MixedTabs', '\s*\( \t\|\t \)\s*')
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
call matchadd('ExtraWhitespace', '\s\+$')
map <Leader>cw :s/\s\+$//<CR>

set list
set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+

set scrolloff=3
set undofile

set ignorecase
set smartcase
set gdefault
set showmatch
set hlsearch

set diffopt=filler,vertical

nmap <Leader><Space> :noh<CR><Plug>(clever-f-reset)
nnoremap <Tab> %
vnoremap <Tab> %

set wrap

nnoremap j gj
nnoremap k gk

nnoremap ; :

set clipboard=unnamed

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set viewoptions=folds,cursor,slash,unix
let g:skipview_files = ['\.vim$', 'vimrc$',
      \ '\.git[/\\]\(.*[/\\]\)\?COMMIT_EDITMSG$',
      \ '\.git[/\\]\(.*[/\\]\)\?MERGE_MSG$',
      \ '\.git[/\\]\(.*[/\\]\)\?TAG_EDITMSG$',
      \ 'git-rebase-todo$',
      \ '\.diff$',
      \ '^/private/', '^/tmp/', '[/\\]Temp[/\\]']

set nofoldenable
set foldmethod=indent

set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Refocus folds
nnoremap <Leader>z zMzvzz

" Make zO recursively open whatever top level fold we're in,
" no matter where the cursor happens to be.
nnoremap zO zCzO

function! MyFoldText()
    let line = getline(v:foldstart)

    redir => signs
      silent execute 'sign place buffer=' . bufnr('%')
    redir END
    let signcolwidth = 0
    if len(split(signs, '\n')) > 2
      let signcolwidth = 2
    endif

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - signcolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '… '
endfunction
set foldtext=MyFoldText()

let g:syntastic_puppet_puppetlint_args = "--no-class_inherits_from_params_class-check --no-80chars-check"
let g:syntastic_sh_shellcheck_args = "-e SC1090,SC1091"
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
nnoremap ln :lne<CR>
nnoremap lN :lNe<CR>
nnoremap lo :lop<CR>
nnoremap lc :lcl<CR>

nnoremap <F5> :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1

nnoremap <F3> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=1

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

au FileType git* setlocal noundofile
au FileType gitconfig,sh setlocal noexpandtab shiftwidth=8 tabstop=8 listchars+=tab:\ \ 
au BufNewFile,BufRead *.git/{,modules/**/}TAG_EDITMSG setlocal textwidth=80
au FileType diff setlocal noundofile
au BufNewFile,BufRead *.eyaml setf yaml
au FileType javascript setlocal foldmethod=syntax

set number
set relativenumber

let g:clever_f_smart_case = 1

function! Untab()
  let curline = getline('.')
  let curcol = col('.')
  let curchar = curline[curcol - 1]
  let prevchar = curline[curcol - 2]
  if curcol > 1 && (prevchar == " " || prevchar == "\t") ||
        \(curcol == len(curline) && curchar == " " || curchar == "\t")
    call feedkeys("\<BS>")
  endif
endfunction

imap <S-Tab> <C-O>:call Untab()<CR>

let g:airline#extensions#branch#format = 1

set updatetime=1000

let g:NERDSpaceDelims=1

function! DisableUndofileWhenTemp()
  let tempdirs = [ expand($TEMP), expand($TMP), expand($TMPDIR) ]
  for tempdir in tempdirs
    if strlen(tempdir) == 0
      continue
    endif
    let tempdir = resolve(tempdir)
    let templen = strlen(tempdir) - 1
    if tempdir ==? resolve(expand('%:p'))[0:templen]
      setlocal noundofile
      setlocal noswapfile
      break
    endif
  endfor
endfunction
au BufNewFile,BufRead * call DisableUndofileWhenTemp()

set viminfo+=n~/.viminfo
