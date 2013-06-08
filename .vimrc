"set runtimepath^=$MYVIM

" load all bundles from .vim/bundles directory
filetype off
execute pathogen#infect()
"call pathogen#incubate()
"call pathogen#runtime_append_all_bundles()
call pathogen#helptags()    " generate helptag documentation for any existing bundles

"
" some basic settings
"
set nocompatible            " enable VIM improvements
scriptencoding utf-8        " I like utf-8
set encoding=utf-8          " I really do
set fileformat=unix         " I like unix files too
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
set listchars+=nbsp:¶
set listchars+=extends:»
set listchars+=precedes:«
set showbreak=↪             " the character to put to show a line has been wrapped

"
" color and display related
"
color slate                 " choose color scheme
set hlsearch!               " highlight search hits
set showmatch               " highlight matching braces/brackets/parentheses
set matchtime=5             " # of 10ths of a second to blink matching brackets
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
"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

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
set autoread                " auto reload files modified in the background

"
" folding related
"
"set foldmethod=indent       " set indentation mode (manual|indent|syntax|...)
"set foldminlines=2          " minimum number of lines to fold by default
"set foldlevelstart=1        " start at level 1

"
" solarize colorscheme
"
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
set statusline=%f           "full filepath - %f filepath, %t tail of filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]     "file format
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''} " display a warning if file encoding isn't utf-8
set statusline+=%*
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''} " display a warning if fileformat isn't unix
set statusline+=%*
set statusline+=%h          "help file flag
set statusline+=%m          "modified flag
set statusline+=%r          "read only flag
set statusline+=%y          "filetype
set statusline+=%=          "left/right separator
"set statusline+=%{StatuslineLongLineWarning()} " display long line warnings
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()} " display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%*
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()} " syntastic errors/warnings
set statusline+=%*
"set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=\ %c,       "cursor column
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
set undofile                " undo feature (even between exits)
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
autocmd FileType ruby,haml,eruby,yaml,sass setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python set expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent autoindent
autocmd FileType text setlocal textwidth=78

autocmd BufRead,BufNewFile {*.scss,*.sass} setfiletype sass
autocmd BufRead,BufNewFile *.txt setfiletype text
autocmd BufRead,BufNewFile {*.md,*.markdown,*.mkd} set filetype=markdown autoindent formatoptions=tcroqn2 comments=n:&gt;
autocmd BufRead,BufNewFile {*.csv,*.dat,*.tsv} setfiletype csv

" auto save on lost focus
"autocmd FocusLost * :wa

"
" special mappings and functions
"

" use :w!! command to save file with sudo
cmap w!! %!sudo tee > /dev/null %

" <F2> inverts paste option in normal mode
nnoremap <f2> :set invpaste paste?<cr>
" <F2> toggles paste option in insert mode
set pastetoggle=<f2>

" split window movement mappings
nnoremap <silent> <a-up> :wincmd k<cr>
nnoremap <silent> <a-down> :wincmd j<cr>
nnoremap <silent> <a-left> :wincmd h<cr>
nnoremap <silent> <a-right> :wincmd l<cr>

" open previous buffer
nnoremap <leader>l :bprevious<cr>

" reselect previously used text (to e. g. indent pasted text)
nnoremap <leader>m V`]

" create new vertical and horizontal split and change to it
nnoremap <leader>v <c-w>v<c-w>l
nnoremap <leader>h <c-w>s<c-w>j

cnoremap %% <c-r>=expand('%:h').'/'<cr>
map <leader>o :edit %%
" map <leader>v :view %%

" make vim search use less confusing regex syntax by default (perl compatible)
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %s/\v

" turn off search highlighting
nnoremap <leader><cr> :noh<cr>

" reformat entire file and reset cursor to last position
noremap <silent><leader>k gg=G``

" unmap help key
inoremap <f1> <esc>
nnoremap <f1> <esc>
vnoremap <f1> <esc>

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
nnoremap <silent> <space> @=(foldlevel('.')?'za':"\<space>")<cr>
vnoremap <space> zf
inoremap <f9> <c-o>za
nnoremap <f9> za
onoremap <f9> <c-c>za
vnoremap <f9> zf

"augroup filetype_html
"    autocmd!
"    " fold tag
"    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
"augroup END

" Escape/unescape & < > HTML entities in range (default current line).
function! HtmlEntities(line1, line2, action)
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2
  if a:action == 0  " must convert &amp; last
    execute range . 'sno/&lt;/</eg'
    execute range . 'sno/&gt;/>/eg'
    execute range . 'sno/&amp;/&/eg'
  else              " must convert & first
    execute range . 'sno/&/&amp;/eg'
    execute range . 'sno/</&lt;/eg'
    execute range . 'sno/>/&gt;/eg'
  endif
  nohl
  let @/ = search
endfunction
command! -range -nargs=1 Entities call HtmlEntities(<line1>, <line2>, <args>)
noremap <silent> \h :Entities 0<CR>
noremap <silent> \H :Entities 1<CR>

" rename current file to something else
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" append modeline after last line in buffer
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :", &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<cr>

"
" settings for bundles etc.
"

" use ack from within vim
nnoremap <leader>a :Ack

" nerdcommenter settings
let NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {
      \ 'puppet': { 'left': '#', 'leftAlt': '/*', 'rightAlt': '*/' }
      \ }
let NERDAllowAnyVisualDelims = 1
let NERDCompactSexyComs = 0
let NERDSexyComMarker = ""

" disable folding for vim-markdown syntax highlighting
let g:vim_markdown_folding_disabled=1

" syntastic: check syntax on file open
let g:syntastic_check_on_open=1

" syntastic: configuration and checkers
let g:syntastic_python_checkers=['pylint']
let g:syntastic_php_checkers=['php'] " 'phpcs', 'phpmd'
let g:syntastic_twig_checkers=['twig-lint']

" syntastic: map for errors window
nnoremap <leader>e :Errors<cr>

" syntastic: autoclose error window when there are no errors
let g:syntastic_auto_loc_list=2

" syntastic: checking mode
"let g:syntastic_mode_map = { 'mode': 'active',
"    \ 'active_filetypes': ['ruby', 'python', 'perl', 'shell', 'puppet' ],
"    \ 'passive_filetypes': ['php', 'html'] }

" Gundo.vim plugin: toggle undo tree and preview pane
nnoremap <f5> :GundoToggle<cr>

" git-commit-diff plugin to automatically view git diff while writing a commit message
let g:git_diff_spawn_mode=1
let g:git_diff_opts="-C -C"
autocmd BufRead,BufNewFile COMMIT_EDITMSG setf git

" vim-numbertoggle
let g:NumberToggleTrigger="<f3>"

" vim: set ts=4 sw=4 tw=78 et :
