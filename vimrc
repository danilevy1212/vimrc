""" PLUGINS, using Plugged package manager
" Auto install Plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin declaration begin
call plug#begin('~/.vim/plugged')

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

" FZF integrationa (requires fzf installed)
Plug 'junegunn/fzf.vim'

" Uncomment if you want fzf to be installed by Plugged
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Preview substitutions (:OverCommandLine)
Plug 'osyo-manga/vim-over'

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

" Completion Engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Intellij Integration
if has('nvim')
    Plug 'beeender/Comrade'
else
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Better tab management
Plug 'gcmt/taboo.vim'

" Ranger in vim
Plug 'francoiscabrol/ranger.vim'

" Close buffers without closing windows with <leader>bd (Also ranger.vim dep)
Plug 'rbgrouleff/bclose.vim'

" Function signature
Plug 'Shougo/echodoc.vim'

" Fancy starting screen
Plug 'mhinz/vim-startify'

" Ale GoToDefinitions
Plug 'dense-analysis/ale'

" Easymotion
Plug 'easymotion/vim-easymotion' 

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
set nu rnu

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

" Enable incrsearch
set is

" Enable command preview (nvim)
if has('nvim')
  set inccommand="nosplit"
endif

" AutoComplete commands
set wmnu
set wim=longest,list,full

" Provides tab-completion for all file-related tasks
set path+=**

" Saves the buffer whenever text is changed FIXME
" autocmd TextChanged,TextChangedI <buffer> silent write

" Squeeze extra spaces (evil-lion)
let b:lion_squeeze_spaces=1

"" tabspaces (For all filetypes, unless specified)
" The width of a TAB is set to 4.
set tabstop=2
" Indents will have a width of 4.
set shiftwidth=2
" Sets the number of columns for a TAB.
set softtabstop=2
" Expand TABs to spaces.
set expandtab

" Use ag for Gsearch
set grepprg=ag
let g:grep_cmd_opts='--line-numbers --noheading'

" augment the default foldtext() with an indicator of whether the folded lines have been changed.
set foldtext=gitgutter#fold#foldtext()

"" Deoplate
" start automatically
let g:deoplete#enable_at_startup=1

" include signature
set completeopt+=preview

"" Echodoc
" Enabled by default
let g:echodoc_enable_at_startup=1

" Cool virtual docstring
let g:echodoc#type = 'virtual'

" Jedi
" Disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled=0

" show call signature
let g:jedi#show_call_signatures=1

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers="right"

" make space in cmnd line
set noshowmode

"" Ranger
" Custom command
let g:ranger_command_override='ranger --cmd "set show_hidden=true"'

" No default keybinding
let g:ranger_map_keys=0

" Open ranger when vim opens a directory
let g:ranger_replace_netrw=1

" Disable ale completion FIXME: Make it file specific
let g:ale_completion_enabled=0
let g:ale_completion_max_suggestions=0

"" Exercisim Help function
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

autocmd BufRead *.{vader,vim}
      \ command! -buffer Test call s:exercism_tests()

"" Ale 
" Disable ale for python files
let g:ale_pattern_options = {
\   '\.py$': {
\       'ale_enabled': 0
\   },
\}

" Vue and typescript
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'tslint'],
\   'vue': ['eslint', 'vls']
\}

let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['prettier'],
\    'vue': ['eslint'],
\    'scss': ['prettier'],
\    'html': ['prettier']
\}

""" Startify
let g:startify_bookmarks = [ '~/.vim/vimrc', '~/.config/zsh/.zshrc' ]

"""  Keybindings
" Map leader key to space
let mapleader=" "

" CTRL + l to unhighlight text
nnoremap <C-l> :nohl<CR><C-l>

""Terminal
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

"" FZF 
"Look for a file
nnoremap <silent> <Leader>f :Files<CR>

" Alt x shows commands (like emacs)
noremap <M-x> :Commands<CR>^

" Buffer list
noremap <Leader>bb :Buffers<CR>^

"" Ranger
"Open file browser (Ranger)
map <Leader>e :Ranger<CR>

"" Vim-sneak
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

" Fugitive, git status
nnoremap <Leader>gs :Git<cr>

"" Deoplate complition
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#mappings#manual_complete()

inoremap <silent><expr> <S-TAB>
            \ pumvisible() ? "\<C-p>" :
            \ <SID>check_back_space() ? "\<S-TAB>" :
            \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"" Prettier 
nmap <Leader>p <Plug>(PrettierPartial)

"" Ale Keybindings
" Go to definition
nnoremap <Leader>d <Plug>(ale_go_to_definition_in_vsplit)

" Go to documentation
nnoremap <silent> <K> <Plug>(ale_documentation)

"" Presentation
" 24-bit color
set termguicolors

" Colorscheme
colorscheme onedark

" Airline Theme
let g:airline_theme='onedark'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled=1
let g:airline_skip_empty_sections=1

" Highlight searches
set hlsearch

" Activate rainbow delimeters
let g:rainbow_active=1

" Git Gutter Higher refresh rate
set updatetime=250

"" Taboo options
" terminal style tabs even in gui versions
set guioptions-=e

" remember tabs in sessions
set sessionoptions+=tabpages,globals

" Split windows below or on the right
set splitbelow splitright

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

