"set runtimepath^=$MYVIM

" load all bundles from .vim/bundles directory
filetype off
execute pathogen#infect()
"call pathogen#incubate()

"
" some basic settings
"
set nocompatible            " enable VIM improvements
scriptencoding utf-8        " I like utf-8
set encoding=utf-8          " I really do

let mapleader=","           " use , instead of \ as the leader key

"
" text, tabs, whitespace and indentation related
"
set expandtab               " convert tabs to type/size (spaces for us)
set shiftwidth=4            " amount of spaces when shifting (indentation length)
set tabstop=4               " tab width/length
set softtabstop=4           " soft tab width in spaces
set smarttab                " enable smart indentation
set autoindent              " enable auto indentation
set backspace=2             " indent,eol,start - Backspace through everything
set list                    " show invisible characters
set listchars=tab:›\        " set tabulator character
set listchars+=trail:⋅      " set trailing whitespace character
"set listchars+=eol:¬       " set end-of-line character
set showbreak=↪             " the character to put to show a line has been wrapped

"
" color and display related
"
color slate                 " choose color scheme
set hlsearch!               " highlight search hits
set showmatch               " highlight matching braces/brackets/parentheses
"set number                 " display absolute line numbers
set relativenumber          " display relative line numbers
set cursorline              " highlight current line
set cursorcolumn            " highlight current column
set ruler                   " show the cursor position all the time
set colorcolumn=80,120      " highlight various character limits
set laststatus=2            " always show the status bar even if there's only one window
set showcmd                 " show command characters
set showmode                " show the current (paste) mode on the open buffer
set splitbelow              " splits show up below by default
set splitright              " splits go to the right by default
set title                   " set the title for gvim
set novisualbell            " do not use a visual bell for notifications

"
" search related
"
set ignorecase              " make search case insensitive
set incsearch               " enable incremental search (search while typing)
set smartcase               " preserve case when replacing

"
" some more useful settings
"
"set t_Co=256               " use 256 colors
"set t_Co=16
set t_ti= t_te=             " enable scrolling in scrollback buffer (http://www.shallowsky.com/linux/noaltscreen.html)
set scrolloff=999           " increase scrolling offset at buffer end - center cursor with high value
set modelines=5             " interpret 5 lines at bottom for modelines
set modeline                " enable vim modelines usage
set shell=bash              " bash as shell would be nice
set history=5000            " keep 5000 lines of command line history
set timeout timeoutlen=1000 " fix slow O inserts
set ttimeoutlen=10          " fix slow O inserts

"
" folding related
"
"set foldmethod=indent       " set indentation mode (manual|indent|syntax|...)
"set foldminlines=2          " minimum number of lines to fold by default
"set foldlevelstart=1        " start at level 1

"set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized
"
" file and syntax highlighting related
"
syntax on                   " syntax highlighting / filetype detection by syntax
filetype on                 " show filetype
filetype plugin on
filetype indent on

"
" status line relatead
"
set statusline=%F           "full filepath - %f filepath, %t tail of filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]     "file format
set statusline+=%h          "help file flag
set statusline+=%m          "modified flag
set statusline+=%r          "read only flag
set statusline+=%y          "filetype
set statusline+=%=          "left/right separator
set statusline+=%{SyntasticStatuslineFlag()} " syntastic errors/warnings
set statusline+=\ 
set statusline+=%c,         "cursor column
set statusline+=%l/%L       "cursor line/total lines
set statusline+=\ %P        "percent through file

"
" explorer and tree view
"
let g:netrw_liststyle=3     " Use tree-mode as default view
let g:netrw_browse_split=4  " Open file in previous buffer
let g:netrw_winsize=80      " control initial sizing (%)
let g:netrw_alto=0          " control above/below splitting
let g:netrw_altv=0          " control right/left splitting
"let g:netrw_preview=1      " preview window shown in a vertically split

" in many terminal emulators the mouse works just fine, thus enable it
"if has('mouse')
"    set mouse=a
"endif

"
" backup and swap file related
"
set backup                  " create backups
set undofile                " undo feature
set writebackup             " write backup files
set swapfile                " create .swp files
set backupdir=~/.vim/backup,~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/swap,~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.vim/undo,~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

"
" tab completion settings
"
set wildmenu                " enable menu at the bottom
set wildmode=longest:full,full " wildcard matches show a list, matching the longest first, try list:longest
set wildignore+=.git,.hg,.svn " ignore version control repos
set wildignore+=*.pyc       " ignore Python compiled files
set wildignore+=*.rbc       " ignore Rubinius compiled files
set wildignore+=*.swp       " ignore vim backups

"
" editor settings for file types and syntax highlighting specials
"
" define markdown filetype until I had a look at ftplugin/markdown.vim etc.
au BufNewFile,BufRead {*.md,*.mkd,.markdown} set filetype=markdown

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

"
" special mappings and functions
"

" use :w!! command to save file with sudo
cmap w!! %!sudo tee > /dev/null %

" <F2> inverts paste option in normal mode
nnoremap <F2> :set invpaste paste?<CR>
" <F2> toggles paste option in insert mode
set pastetoggle=<F2>

" open previous buffer
nnoremap <leader>l :bprevious<CR>

" reselect previously used text (to e. g. indent pasted text)
nnoremap <leader>m V`]

" create new vertical and horizontal split and change to it
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

" auto save on lost focus
"autocmd FocusLost * :wa

" make vim search use less confusing regex syntax by default (perl compatible)
nnoremap / /\v
vnoremap / /\v

" turn off search highlighting
nnoremap <leader><cr> :noh<cr>

" jump from parenthesis to parenthesis a bit easier
nnoremap <tab> %
vnoremap <tab> %

" code completion
inoremap <c-space> <c-x><c-o>

" ctrl+d to delete line in normal and insert mode
nnoremap <c-d> dd
inoremap <c-d> <esc>ddi

" move current line down and up
nnoremap - ddp
nnoremap _ ddkP

" put single or double quotes around words
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" put single or double quotes around visually selected text
vnoremap <leader>q <esc>`<i'<esc>`>lli'<esc>l
vnoremap <leader>Q <esc>`<i"<esc>`>lli"<esc>l

" strip all trailing whitespace in the current file
nnoremap <leader>stw :%s/\s\+$//<cr>:let @/=''<CR>
" clear whitespace at the end of lines automatically when saving
"autocmd BufWritePre * :%s/\s\+$//e

" fold via <space> or F9 in normal mode (and F9 in visual mode)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

augroup filetype_html
    autocmd!
    " fold tag
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

" append modeline after last line in buffer
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :", &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


"
" settings for bundles etc.
"

" use ack from within vim
nnoremap <leader>a :Ack

" disable folding for vim-markdown syntax highlighting
let g:vim_markdown_folding_disabled=1

" syntastic configuration and checkers
let g:syntastic_python_checkers=['pylint']
let g:syntastic_php_checkers=['php'] " 'phpcs', 'phpmd'
let g:syntastic_twig_checkers=['twig-lint']

" vim: set ts=4 sw=4 tw=78 et :
