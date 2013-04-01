"set runtimepath^=$MYVIM

set nocompatible "enable VIM improvements

" in many terminal emulators the mouse works just fine, thus enable it
if has('mouse')
    set mouse=a
endif

" use , instead of \ as leader key
"let mapleader=","

set shell=bash

set history=5000    " keep 5000 lines of command line history

" enable vim modelines usage (interpret 5 lines at the bottom of files)
set modelines=5
set modeline

" text, tab and indent related
set expandtab       " convert tabs to spaces
set shiftwidth=4    " length for indentation
set tabstop=4       " length for tabs
set smarttab        " enable smart indentation
"set fdm=indent      " set indentation mode
set autoindent      " enable auto indentation
set backspace=indent,eol,start " Backspace through everything

" color/display related
color slate         " choose color scheme
set hls!            " highlight search hits
syntax enable       " enable syntax highlighting
set showmatch       " show matching braces/brackets/parens
set number          " display line numbers
set cursorline      " highlight current line
"set cursorcolumn    " highlight current column
set ruler           " show the cursor position all the time

" search related
set ignorecase      " make search case insensitive
set incsearch       " enable incremental search (search while typing)
set smartcase       " preserve case when replacing

" file related
filetype on         " show filetype
filetype plugin on
filetype indent on

" syntax highlighting specials
au BufNewFile,BufRead *.md set filetype=markdown

" specific file types get specific editor defaults
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" status line
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

set laststatus=2    "always show the status bar even if there's only one window


" explorer and tree view
let g:netrw_liststyle=3     " Use tree-mode as default view
let g:netrw_browse_split=4  " Open file in previous buffer
" let g:netrw_preview=1       " preview window shown in a vertically split
let g:netrw_winsize=80      " control initial sizing (%)
let g:netrw_alto=0          " control above/below splitting
let g:netrw_altv=0          " control right/left splitting

" Prevent Vim from clobbering the scrollback buffer. See http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" keep more context when scrolling off the end of a buffer
set scrolloff=3

" <F2> inverts paste option in normal mode
nnoremap <F2> :set invpaste paste?<CR>
" <F2> toggles paste option in insert mode
set pastetoggle=<F2>
" display whether paste is enabled in insert mode
set showmode

" Store temporary files in a central spot
"set backup
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" prevent vim from creating swap and backup files
"set nobackup
"set nowb
"set noswapfile

" auto save on lost focus
"autocmd FocusLost * :wa

" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=10

" have a look at url for functions: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :", &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


