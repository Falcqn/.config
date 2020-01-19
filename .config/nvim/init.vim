" ------------------------------------------------------------------------------
" Dave Hepworth's VimRC
"
" Requirements:
"   + You must be using NeoVim
"   + Python 3 must be installed, with neovim support installed
"       (pip install neovim)
"   + NodeJS must be installed (for Coc)
"   + You must have Vim-Plug installed
"   + Your terminal must support 256 colours
"   + For best results, use a Powerline patched font
"
" ------------------------------------------------------------------------------

" Auto-Reload this file when written to
autocmd! BufWritePost vimrc source %

" Setup and Config
" ------------------------------------------------------------------------------
set nocompatible    " Remove vi compatibility
set showcmd         " Show previous command in bottom bar
set wildmenu        " Visual autocomplete for command menu e.g. :e ~/.vim<TAB>
set number          " Show line numbers

" Unmap the arrow keys and mouse
no <left> <Nop>
no <down> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <left> <Nop>
ino <down> <Nop>
ino <right> <Nop>
ino <up> <Nop>
set mouse=

" Clear registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
autocmd VimEnter * WipeReg

" File operations
" ------------------------------------------------------------------------------
set autoread        " Auto-read files that change during editing
set autowrite       " Auto-write unwritten buffers when switching
set hidden          " Makes it so buffers are only hidden when switching

set undodir=~/.vim/vimundo  " Persistent undo
set undofile
set undolevels=10000

" Move between buffers with C-J and C-K
map <C-J> <ESC>:bp<CR>
map <C-K> <ESC>:bn<CR>

" Jump to the previous cursor position when reopening a file
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Set the right syntax highlighting for c++ module files
:au BufRead,BufNewFile *.cppm,*.ixx,*.mxx,*.mpp setfiletype cpp

" Searching and ctags
" ------------------------------------------------------------------------------
set incsearch               " Incremental searching
set ignorecase smartcase    " Case-insensitive search
set tags=./.tags;/          " Set relative path to ctags

" Indentation and Whitespace
" ------------------------------------------------------------------------------
set expandtab               " Expand tabs to spaces
set shiftwidth=2            " Set 2 spaces per tab
set tabstop=2               " Align to multiples of 2 columns
set smarttab autoindent     " Enable auto-indentation
set backspace=2             " Allow backspacing over line breaks, autoindents,
                            " and the start of insert

" Clear trailing whitespace in selected file types on save
" autocmd BufWritePre *.py,*.jsx?,*.hs,*.html,*.css,*.scss,*.c,*.h :%s/\s\+$//e

" Common mistypes
" ------------------------------------------------------------------------------
:command! W w
:command! Bd bd
:command! Wq wq
:command! WQ wq
:command! Q q

" Show trailing whitespace except when typing at the end of a line
:match ErrorMsg /\s\+\%#\@<!$/

" Add angle brackets to matched pairs
set matchpairs+=<:>

" Python provider
let g:python3_host_prog = '/usr/bin/python3'

" Plugins
" ------------------------------------------------------------------------------

" Auto-Install vim-plug
let g:plug_location='~/.local/share/nvim/site/autoload/plug.vim'
let g:plug_repository='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if empty(glob(plug_location))
  execute '!curl -fLo ' . g:plug_location . ' --create-dirs ' . g:plug_repository
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Gruvbox :: https://github.com/morhetz/gruvbox
" ------------------------------------------------------------------------------
  Plug 'morhetz/gruvbox'
  let g:gruvbox_contrast_dark='medium'

" Vim-Surround :: http://vimawesome.com/plugin/surround-vim
" ------------------------------------------------------------------------------
" Adds 'in' functionality to quotes (like braces)
" eg di" works like di(
  Plug 'tpope/vim-surround'

" Vim-Repeat :: http://vimawesome.com/plugin/repeat-vim
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-repeat'

" Vim-Airline :: http://vimawesome.com/plugin/vim-airline
" ------------------------------------------------------------------------------
  Plug 'bling/vim-airline'
  let g:airline_theme='distinguished'
  let g:airline_powerline_fonts=0

  " Create the airline symbols table if it doesn't exist
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " Unicode symbols
  " let g:airline_symbols.linenr = '☰'
  " let g:airline_symbols.maxlinenr = ''
  " let g:airline_symbols.notexists = '∄'
  " let g:airline_symbols.whitespace = 'Ξ'

  " Powerline symbols
  " let g:airline_left_sep = ''
  " let g:airline_left_alt_sep = ''
  " let g:airline_right_sep = ''
  " let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''

  " Tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffers_label = 'b'
  let g:airline#extensions#tabline#tabs_label = 't'
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline#extensions#tabline#fnamemod = ':p:.'

" Vim-Airline-Themes :: http://vimawesome.com/plugin/vim-airline-themes
" ------------------------------------------------------------------------------
  Plug 'vim-airline/vim-airline-themes'

" MatchTagAlways :: http://vimawesome.com/plugin/matchtagalways
" ------------------------------------------------------------------------------
  Plug 'valloric/matchtagalways'

" Vim-Polyglot :: http://vimawesome.com/plugin/vim-polyglot
" ------------------------------------------------------------------------------
  Plug 'sheerun/vim-polyglot'

" Conquerer of Completion :: https://github.com/neoclide/coc.nvim
" ------------------------------------------------------------------------------
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " use <tab> for trigger completion and navigate to the next complete item
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <Tab>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<Tab>" :
        \ coc#refresh()

" NerdTree
" ------------------------------------------------------------------------------
  Plug 'scrooloose/nerdtree'
  nmap <C-n> :NERDTreeToggle<CR>
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeWinSize = 48
  let g:NERDTreeWinPos = "right"

  " If more than one window and previous buffer was NERDTree, go back to it.
  " (prevents opening buffers in the nerdtree window)
  autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

  " If only one window left open and it is NERDTree, exit nvim
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree git integration
" ------------------------------------------------------------------------------
  Plug 'Xuyuanp/nerdtree-git-plugin'
    let g:NERDTreeGitStatusWithFlags = 1

  Plug 'ryanoasis/vim-devicons'
  Plug 'airblade/vim-gitgutter'

" fzf :: https://github.com/junegunn/fzf.vim
" Fuzzy Find
" ------------------------------------------------------------------------------
  Plug 'junegunn/fzf.vim'

" Vim-Lawrencium :: https://github.com/ludovicchabant/vim-lawrencium
" ------------------------------------------------------------------------------
" Plug 'ludovicchabant/vim-lawrencium'

" File-Line :: https://github.com/bogado/file-line
" ------------------------------------------------------------------------------
" Adds the ability to open a file and jump to a line using 'nvim file:line'
" Eg 'nvim some_lib.c:23'
  Plug 'bogado/file-line'

" vim-bufkill
" ------------------------------------------------------------------------------
" Kills a buffer without closing the window
  Plug 'qpkorr/vim-bufkill'

call plug#end()

" Set the colour scheme (must be done after the plugins have been added)
set background=dark
colo gruvbox

" Abbreviations
" ------------------------------------------------------------------------------
iab fileheader /* ------------------------------------------------------------------------------<ESC>o File:<ESC>o<BS> Author:<ESC>o<BS>--------------------------------------------------------------------------- */<ESC>o<ESC>

iab breakline /* --------------------------------------------------------------------------- */<ESC>

iab whilei {<ESC>oint i=1;<ESC>owhile (i)<ESC>o;<ESC>o}<ESC>
