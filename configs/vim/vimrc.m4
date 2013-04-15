CONFIG_FILE(vimrc, ~/.vimrc)

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set scrolloff=2		" keep two lines of scroll off
set showcmd		" show the currently typed cmd at the btm right
set whichwrap=b,s,<,>,[,],h,l	" wrap round movement keys over lines
set listchars=tab:⌞\ ,trail:⋅	" set a prettey visible whitespace style
set list		" enable whitespace visibility
set softtabstop=2   " tabkey = 2 spaces
set tabstop=2		" set the width of a tab stop
set copyindent
set shiftwidth=2	" set the width of a shiftwidth (auto indent)
"set expandtab       " all my beloved tabs gone!
set nu		" enable line numbers
set ignorecase		" disable case-sensitivity
set spelllang=en_gb	" I'm british...
" Fix the horrible deletion of auto indents
inoremap <CR> <CR><Space><BS>
nnoremap o o<Space><BS>
nnoremap O O<Space><BS>

"Highlight Long lines (>80chrs):
:let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
:let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

"Auto-wrap long lines
set tw=80

" Some customisations for gvim
set guifont=Monaco\ 7       " A nice font for gvim
set guioptions-=T          " Turn off the toolbar
set guioptions-=m          " Turn off the menu bar
"set guioptions-=r          " Turn off the scroll bars
set guioptions-=l
set guioptions-=b
colorscheme twilight       " A nice theme for gvim

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("gui_running")
  set lines=50 columns=100   " Have a reasonable default size
endif

define(`LQ',`changequote(<,>)`dnl'
changequote`'')
define(`RQ',`changequote(<,>)dnl`
'changequote`'')


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  set autoindent		" always set autoindenting on
  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`'LQ()\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
