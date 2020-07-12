""" PLUGINS, using Plugged package manager
" Auto install Plug if not present
" FIXME Make it compatible with vim, also try to use XDG but put on
" ~/.local/share if not present

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin declaration begin
call plug#begin()

" Test engine for vim
Plug 'junegunn/vader.vim'

" Vim Surround
Plug 'tpope/vim-surround'

" Vim Commentary
Plug 'tpope/vim-commentary'

" Additional matching on pairs, using %
Plug 'vim-scripts/matchit.zip'

" Autoclose paranthesis and other structs
Plug 'tpope/vim-endwise'

" Snipe two chars
Plug 'justinmk/vim-sneak'

" Better sentence detection
Plug 'reedes/vim-textobj-sentence'

" Colortheme
Plug 'joshdick/onedark.vim'

" Powerline (Airline)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" More complete . functionality
Plug 'tpope/vim-repeat'

" This package provides gl and gL align operators:
" gl MOTION CHAR and right-align gL MOTION CHAR.
Plug 'tommcdo/vim-lion'

" Selected text in visual mode with * and # operators
Plug 'nelstrom/vim-visual-star-search'

" Uncomment if you want fzf to be installed by Plugged
Plug 'junegunn/fzf', { 'dir': (expand($XDG_CONFIG_HOME) . '/fzf'), 'do': './install --all --xdg --no-bash --no-fish' }

" FZF integration (requires fzf installed)
Plug 'junegunn/fzf.vim'

if has('nvim') == 0
  " Preview substitutions (:OverCommandLine)
  Plug 'osyo-manga/vim-over'
endif

" Rainbow colored delimeters
Plug 'luochen1990/rainbow'

" Wrapper for common unix operations
Plug 'tpope/vim-eunuch'

" Adds :Gsearch and :wall command for in proyect editing
Plug 'skwp/greplace.vim'

" Git diff within the buffer
Plug 'airblade/vim-gitgutter'

" Magit in vim
Plug 'tpope/vim-fugitive'

" Autopairs
Plug 'jiangmiao/auto-pairs'

" Jedi for python docs
Plug 'davidhalter/jedi-vim'

" Better tab management
Plug 'gcmt/taboo.vim'

" Project structure visualizer
Plug 'preservim/nerdtree'

" NERDTree is git aware
Plug 'Xuyuanp/nerdtree-git-plugin'

" Cool icons
Plug 'ryanoasis/vim-devicons'

" Ranger in vim
Plug 'francoiscabrol/ranger.vim'

" Close buffers without closing windows with <leader>bd (Also ranger.vim dep)
Plug 'rbgrouleff/bclose.vim'

" Function signature
Plug 'Shougo/echodoc.vim'

" Fancy starting screen
Plug 'mhinz/vim-startify'

" Easymotion
Plug 'easymotion/vim-easymotion'

" coc.nvim
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Initialize plugin system
call plug#end()

""" BASIC DEFAULTS
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace wrap around lines.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" turn hybrid-relative line numbers on
set number relativenumber

" if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is
set ignorecase smartcase

" Terminal settings
if has('nvim')
  augroup term_settings
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber clipboard+=unnamedplus
  augroup END
endif

" Encoding
set encoding=utf-8

" Automatically wrap text that extends beyond the screen length.
set wrap

" Speed up scrolling in Vim
set ttyfast

" Enable incremental search
set incsearch

" Enable command preview (nvim)
if has('nvim')
  set inccommand=nosplit
endif

" AutoComplete commands
set wmnu
set wim=longest,list,full

" Provides tab-completion for all file-related tasks
set path+=**

" %#&* swap files
set noswapfile
set nobackup

" Saves the buffer whenever text is changed FIXME
" autocmd TextChanged,TextChangedI <buffer> silent write

"" tabspaces (For all filetypes, unless specified)
" The width of a TAB is set to 4.
set tabstop=2
" Indents will have a width of 4.
set shiftwidth=2
" Sets the number of columns for a TAB.
set softtabstop=2
" Expand TABs to spaces.
set expandtab

" Use the silver searcher for grep search
set grepprg=ag
let g:grep_cmd_opts='--line-numbers --noheading'

" include signature
set completeopt=menuone,noselect

" make space in cmd line
set noshowmode
set cmdheight=2

"" Git Gutter
" augment the default foldtext() with an indicator of whether the folded lines have been changed.
set foldtext=gitgutter#fold#foldtext()

"" Lion
"Squeeze extra spaces (evil-lion)
let b:lion_squeeze_spaces=1

"" Echodoc
" Enabled by default
let g:echodoc_enable_at_startup=1

" Cool virtual docstring
let g:echodoc#type = 'virtual'

"" Ranger
" Custom command
let g:ranger_command_override='ranger --cmd "set show_hidden=true"'

" No default keybinding
let g:ranger_map_keys=0

" Open ranger when vim opens a directory
let g:ranger_replace_netrw=1

"" NERDTree
" CWD when using :NERDTreeFind
let g:NERDTreeChDirMode=2

" Hide help text
let g:NERDTreeMinimalUI=1

" Auto delete a buffer I changed with NERDTree
let g:NERDTreeAutoDeleteBuffer=1

" Show hidden files
let g:NERDTreeShowHidden=1

" Where to keep bookmarks file
let g:NERDTreeBookmarksFile=expand($XDG_DATA_HOME) . "/NERDTreeBookmarks"

"" Exercisim
" Help function
function! s:exercism_tests()
  if expand('%:e') == 'vim'
    let testfile = printf('%s/%s.vader', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(sourcefile)
      echoerr 'File does not exist: '. sourcefile
      return
    endif
    execute 'source' sourcefile
    Vader
  endif
endfunction

" FIXME put this in the ftplugin folder they belong too
autocmd BufRead *.{vader,vim}
      \ command! -buffer Test call s:exercism_tests()

""" Startify
let g:startify_bookmarks = [ expand('$MYVIMRC'), join([expand('$XDG_CONFIG_HOME'),'/zsh/.zshrc'],'')]

""" Keybindings
" Map leader key to space
let mapleader=" "

" CTRL + l to unhighlight text
nnoremap <C-l> :nohl<CR><C-l>

" Quickly exit insert mode
inoremap jk <esc>

"" Terminal
if has('nvim')
  " Call the terminal on another window
  nnoremap <Leader>t :vsplit term://zsh<CR>i

  " Call terminal in same window
  nnoremap <Leader>T :terminal<CR>i

  " Alias to get into normal mode
  tnoremap <C-v><Esc> <C-\><C-n>

  " Paste to terminal
  tnoremap <M-r> <C-\><C-n>"+pi
endif

" Open my vimrc
nnoremap <leader>pp :vsplit $MYVIMRC<CR>

" Reload my vimrc
nnoremap <leader>pR :source $MYVIMRC<CR>

"" FZF
"Look for a file
nnoremap <silent> <Leader>ff :Files<CR>

" Alt x shows commands (like emacs)
noremap <M-x> :Commands<CR>^

" Buffer list
noremap <Leader>bb :Buffers<CR>^

"" Ranger
" Open file browser (Ranger)
nnoremap <M-z> :Ranger<CR>

"" NERDTree
nnoremap <Leader>pe :NERDTreeToggleVCS<CR>

" Vim-sneak
" replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" swap repeat keys FIXME Do this for emacs (evil-snipe) too
map , <Plug>Sneak_;
map ; <Plug>Sneak_,

"" Easymotion
" vim-sneak like keybindings
nmap <Leader><Leader>s <Plug>(easymotion-f2)
nmap <Leader><Leader>S <Plug>(easymotion-F2)

"" vim-gitgutter
" Remove default keybindings
let g:gitgutter_map_keys=0

" Jump to hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Hunk text objects
onoremap ih <Plug>(GitGutterTextObjectInnerPending)
onoremap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" g-based hunk staging/unstaging
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

" g-based hunk previews
nmap ghp <Plug>(GitGutterPreviewHunk)

" Fugitive, g_it status
nnoremap <Leader>gs :Git<cr>

"" coc.nvim FIXME Keybindings don't work
" FIXME make it file specific
" FIXME not good enough for vue files with typescript!
" Prettier for formating
command! -nargs=0 Prettier :CocCommand prettier.formatFile


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation. (<leader>f_ile)
nmap <leader>fd <Plug>(coc-definition)
nmap <leader>ft <Plug>(coc-type-definition)
nmap <leader>fi <Plug>(coc-implementation)
nmap <leader>fr <Plug>(coc-rename)
nmap <leader>fn <Plug>(coc-references)

" , current mode commands
nnoremap <leader>,r :CocRestart<CR>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"" Presentation
" 24-bit color
if exists('+termguicolors')
  set termguicolors
endif

" Highlight searches
set hlsearch

" Git Gutter Higher refresh rate
set updatetime=250

"" Taboo options
" terminal style tabs even in gui versions
set guioptions-=e

" remember tabs in sessions
set sessionoptions+=tabpages,globals

" Split windows below or on the right
set splitbelow splitright

"" Rainbow paranthesis
" Activate rainbow delimeters
let g:rainbow_active=1

"" Colorscheme
colorscheme onedark

"" Airline Theme
let g:airline_theme='onedark'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled=1
let g:airline_skip_empty_sections=1

" gvim only
if has('gui_running')
    " menu bar
    set guioptions-=m
    " toolbar
    set guioptions-=T
    " scrollbar
    set guioptions-=r
    set guioptions-=L
endif

" nvim_gui only
function DisableGUI_TablineAndPopupmenu()
  if has('nvim') && exists('g:GuiLoaded')
    GuiTabline 0
    GuiPopupmenu 0
  endif
endfunction

augroup nvim_gui
  autocmd!
  autocmd UIEnter * call DisableGUI_TablineAndPopupmenu()
augroup END
