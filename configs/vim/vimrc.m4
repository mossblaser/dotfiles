Install vim plugins from git
define(VIM_PLUGIN, `GIT_REPO(~/.vim/bundle/$1, $2)')

* Vim Package management
  VIM_PLUGIN(pathogen, https://github.com/tpope/vim-pathogen.git)

* Adds the "surround" range, e.g. cs"' changes surrounding " to '.
  VIM_PLUGIN(surround, https://github.com/tpope/vim-surround.git)

* Adds commands for aligning on certain characters, e.g. :Tab /= to align on =.
  VIM_PLUGIN(tabular, https://github.com/godlygeek/tabular.git)

* Development version of markdown syntax highlighting for all *.md
  VIM_PLUGIN(markdown, https://github.com/tpope/vim-markdown.git)

* Make . work correctly for a number of plugins (e.g. surround)
  VIM_PLUGIN(repeat, https://github.com/tpope/vim-repeat.git)

* Defines new ii, ai, iI, aI objects for regions of similarly indented code
  VIM_PLUGIN(indent-object, https://github.com/michaeljsmith/vim-indent-object.git)

* Defines :rename to change a file's name, delete the old one
  VIM_PLUGIN(rename, https://github.com/danro/rename.vim.git)

* Adds :CtrlP fuzzy search
  VIM_PLUGIN(ctrlp, https://github.com/ctrlpvim/ctrlp.vim)

CONFIG_FILE(vimrc, ~/.vimrc)
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Add pathogen to the path and make it autoload all bundles
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" show the cursor position all the time
set ruler
" display incomplete commands
set showcmd

" do incremental searching
set incsearch
" disable case-sensitivity in search
set ignorecase

" keep two lines of scroll off
set scrolloff=2

" Auto-wrap long lines
set tw=79

" wrap round movement keys over lines
set whichwrap=b,s,<,>,[,],h,l

" Visually break long lines at word boundaries
set wrap
set linebreak
" Indent wrapped lines
set breakindent
" Prefix the start of wrapped lines with a newline-symbol and a space
set showbreak=\ \ \ \ ↳

" enable whitespace visibility
set list
" set a prettey visible whitespace style
set listchars=tab:⌞\ ,trail:⋅

" set the width of a tab stop
set softtabstop=2
set tabstop=2
" set the width of an auto indent
set shiftwidth=2
" turn tabs into spaces
"set expandtab
" Round indentation inserted with > and < to multiples of shift width
set shiftround

" Fix the horrible deletion of auto indents
inoremap <CR> <CR><Space><BS>
nnoremap o o<Space><BS>
nnoremap O O<Space><BS>

" Autoindent by copying previous line
set copyindent

" enable line hybrid relative linenumbers
set number
set relativenumber

" I'm british...
set spelllang=en_gb

" Some customisations for gvim
" A nice font for gvim
ON_COMPUTER(PERSONAL)
INSTALL_BINARY(Monaco_Linux.ttf,~/.fonts/)
set guifont=Monaco\ 7
ELSE_COMPUTER()
set guifont=Monospace\ 8
END_COMPUTER()
" Turn off the toolbar
set guioptions-=T
" Turn off the menu bar
set guioptions-=m
" Turn off the scroll bars
"set guioptions-=r " right scrollbar
set guioptions-=l  " left scrollbar
set guioptions-=b  " bottom scrollbar

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Have a reasonable default size for GUI sessions
if has("gui_running")
  set lines=50 columns=100
endif

" set autoindenting on
set autoindent
