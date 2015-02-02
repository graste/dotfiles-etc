
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
let mapleader=","           " use , instead of \ as the leader key
set confirm                 " get a dialog when :q, :w, or :wq fails
set hidden                  " buffer becomes hidden when it is abandoned
set lazyredraw              " no redraws in macros
set viminfo^=%              " remember info about open buffers on close

"
" encoding and newlines
"
scriptencoding utf-8        " I like utf-8
set encoding=utf-8          " I really do
set fileformat=unix         " I like unix files too

"
" text, tabs, whitespace and indentation related
"
set autoindent              " enable auto indentation
set backspace=2             " indent,eol,start - Backspace through everything
set expandtab               " convert tabs to type/size (spaces for us)
set list                    " show invisible characters
set listchars=tab:›\        " set tabulator character
set listchars+=extends:»
set listchars+=nbsp:¶
set listchars+=precedes:«
set listchars+=trail:⋅      " set trailing whitespace character
"set listchars+=eol:¬       " set end-of-line character
set shiftwidth=4            " amount of spaces when shifting (indentation length)
set shiftround              " round indent to multiple of shiftwidth
set showbreak=↪             " the character to put to show a line has been wrapped
set smarttab                " enable smart indentation
set softtabstop=4           " soft tab width in spaces
set tabstop=4               " tab width/length

"
" color and display related
"
color slate                 " choose color scheme
"set colorcolumn=81,121      " highlight various character limits
"call matchadd('ColorColumn', '\%81v', 100)  " only highlight 81st column in long lines
call matchadd('ColorColumn', '\%121v', 100) " only highlight 121st column in long lines
set cursorcolumn            " highlight current column
set cursorline              " highlight current line
set hlsearch!               " highlight search hits
set laststatus=2            " always show the status bar even if there's only one window
set matchpairs+=<:>         " allow ci< or di< etc. to work (instead of only ci" etc.)
set matchtime=5             " # of 10ths of a second to blink matching brackets
set noerrorbells            " no annoying sound on errors
set novisualbell            " do not use a visual bell for notifications
"set number                 " display absolute line numbers
set relativenumber          " display relative line numbers
set ruler                   " show the cursor position all the time
set showcmd                 " show command characters
set showmatch               " highlight matching braces/brackets/parentheses
set showmode                " show the current (paste) mode on the open buffer
set splitbelow              " splits show up below by default
set splitright              " splits go to the right by default
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set title                   " set the title for gvim

"
" search related
"
set ignorecase              " make search case insensitive
set incsearch               " enable incremental search (search while typing)
set smartcase               " preserve case when replacing

"
" some more useful settings
"
set autoread                " auto reload files modified in the background
set history=5000            " keep 5000 lines of command line history
set shell=bash              " bash as shell would be nice
"set t_Co=256               " use 256 colors
set t_ti= t_te=             " enable scrolling in scrollback buffer (http://www.shallowsky.com/linux/noaltscreen.html)
set vb t_vb=                " no visual bell in terminals
set timeout timeoutlen=500  " fix slow O inserts
set ttimeoutlen=10          " fix slow O inserts
set modeline                " enable vim modelines usage
set modelines=20            " interpret N lines to check for modelines
"set nomodeline              " disable modelines due to security concerns

"
" scrolling settings (when getting close to margins)
"
set scrolloff=999           " increase scrolling offset at buffer end - center cursor with high value
set scrolloff=10
set sidescrolloff=15
set sidescroll=1

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
" status line related
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
let g:netrw_winsize=60      " control initial sizing (%)
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
set swapfile                " create .swp files
set writebackup             " write backup files
set undofile                " undo feature (even between exits)
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
set wildignore+=*.so,*.swp,*.zip,*.gz,*.min.js,*.o " ignore some more filetypes
" ignore some files when using TAB key with :e
set suffixes=~,.bak,.dvi,.hi,.o,.pdf,.gz,.idx,.log,.ps,.swp,.tar,.toc,.ind

"
" editor settings for file types and syntax highlighting specials
"
autocmd FileType make setlocal tabstop=4 noexpandtab
autocmd FileType markdown setlocal shiftwidth=4 tabstop=4
autocmd FileType python set expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent autoindent
autocmd FileType ruby,haml,eruby,yaml,sass setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType text setlocal textwidth=78
autocmd FileType twig setlocal filetype=htmltwig
autocmd FileType vim setlocal shiftwidth=2 tabstop=2

autocmd BufRead,BufNewFile {*.csv,*.dat,*.tsv} setfiletype csv
"autocmd BufRead,BufNewFile {*.md,*.markdown,*.mdown,*.mkd} set filetype=markdown autoindent formatoptions=tcroqn2 comments=n:&gt; wrap textwidth=80 wrapmargin=0 linebreak
autocmd BufRead,BufNewFile {*.md,*.markdown,*.mdown,*.mkd} set filetype=markdown autoindent formatoptions=tcroqn2 comments=n:&gt;
autocmd BufRead,BufNewFile {*.scss,*.sass} setfiletype sass
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
autocmd BufRead,BufNewFile *.txt setfiletype text

" auto save on lost focus
"autocmd FocusLost * :wa

"
" special mappings and functions
"

" switch indentation to 2 or 4 characters
nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>

" use :w!! command to save file with sudo
cmap w!! %!sudo tee > /dev/null %

" <F2> inverts paste option in normal mode
nnoremap <f2> :set invpaste paste?<cr>
" <F2> toggles paste option in insert mode
set pastetoggle=<f2>

" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
command FixM mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" split window movement mappings via ctrl+up/left/down/right
nnoremap <silent> <c-up> :wincmd k<cr>
nnoremap <silent> <c-down> :wincmd j<cr>
nnoremap <silent> <c-left> :wincmd h<cr>
nnoremap <silent> <c-right> :wincmd l<cr>

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

" make vim search use perl compatible regex syntax by default
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

" always jump to the last known cursor position (if possible and not in an event handler)
" this is replaced atm by the .vim/bundle/graste/plugin/lastpos.vim
"autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


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

" the following two functions are from http://amix.dk/vim/vimrc.txt
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" * or # searches for the current selection in visual mode
vnoremap <silent> * :call VisualSelection('f')<cr>
vnoremap <silent> # :call VisualSelection('b')<cr>
" search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" delete trailing whitespace when saving certain file types
func! DeleteTrailingWhitespace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite {*.py,*.coffee} :call DeleteTrailingWhitespace()

"
" settings for bundles etc.
"

" use ack from within vim
nnoremap <leader>a :Ack

" nerdcommenter settings
let g:NERDCustomDelimiters = {'puppet': { 'left': '#', 'leftAlt': '/*', 'rightAlt': '*/' } }
let NERDAllowAnyVisualDelims = 1
let NERDCompactSexyComs = 0
let NERDSexyComMarker = ""
let NERDSpaceDelims = 1

" disable folding for vim-markdown syntax highlighting
let g:vim_markdown_folding_disabled=1

" syntastic: check syntax on file open
let g:syntastic_check_on_open=1

" syntastic: configuration and checkers
let g:syntastic_php_checkers=['php'] " 'phpcs', 'phpmd'
let g:syntastic_python_checkers=['pylint']
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
let g:git_diff_opts="-C -C"
let g:git_diff_spawn_mode=1
autocmd BufRead,BufNewFile COMMIT_EDITMSG setf git

" vim-numbertoggle
let g:NumberToggleTrigger="<f3>"

" NerdTree
" - open with <Leader>n
" - match folder to currently open file with <Leader>nm
" - open automatically when no cmdline args were given
" - close vim automatically when nerdtree is the last open window
" - show hidden files by default (dotfiles)
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>nm :NERDTreeFind<cr>
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 40

" CtrlP
"let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0 " do not clear cache on exit
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_show_hidden = 1     " scan for dotfiles and dotdirs
let g:ctrlp_max_files = 50000   " maximum number of files to scan (0 = no limit)
let g:ctrlp_max_depth = 40      " maximum depth of dirtree to recurse into
let g:ctrlp_max_history = 100   " set to '&history' to use vim's history option
let g:ctrlp_follow_symlinks = 0 " do not follow symlinks
let g:ctrlp_lazy_update = 1     " update match-window after a certain time (1=250ms, >1 is interpreted as delay time in milliseconds)
let g:ctrlp_mruf_max = 250      " number of files to remember for MRU mode (most-recently-used)
let g:ctrlp_custom_ignore = '\v\/(build|cache|modules-built)\/'
nmap <c-p> :CtrlPMixed<cr>
nmap <Leader>b :CtrlPBuffer<cr>
nmap <Leader>f :CtrlPMixed<cr><c-\>w
"nmap <f8> :<c-u>CtrlP<cr><c-\>w
"vmap <f8> :<c-u>CtrlP<cr><c-\>v
"map <2-LeftMouse> :<c-u>CtrlP<cr><c-\>w

" Tabular
command CsvAlign Tabularize /;/r1

" vim-vertical-move
let g:vertical_move_default_mapping = 0
"nmap <silent> <leader>j <Plug>(vertical_move_down)
nmap <silent> <leader><down> <Plug>(vertical_move_down)
"nmap <silent> <leader>k <Plug>(vertical_move_up)
nmap <silent> <leader><up> <Plug>(vertical_move_up)
"xmap <silent> <leader>j <Plug>(vertical_move_down)
xmap <silent> <leader><down> <Plug>(vertical_move_down)
"xmap <silent> <leader>k <Plug>(vertical_move_up)
xmap <silent> <leader><up> <Plug>(vertical_move_up)

" Reformat visual selection as JSON
vnoremap <leader>j !python -m json.tool<cr>

" vim-php-namespace (USE statements and FQCNs)
" insert use statement for word under cursor
inoremap <leader>u <c-o>:call PhpInsertUse()<cr>
noremap <leader>u :call PhpInsertUse()<cr>
" expand class under cursor to fully qualified class name
inoremap <leader>e <C-O>:call PhpExpandClass()<cr>
noremap <leader>e :call PhpExpandClass()<cr>

" enable ctags support and tell vim to automatically
" recursively search in parent directories for tags file
set autochdir
set tags=./tags;

" some custom mappings for ctags
map <leader>g <c-]>
map <leader>gt <c-t>
map <leader>gh :tab split<cr>:exec("tag ".expand("<cword>"))<cr>
map <leader>gv :vsp <cr>:exec("tag ".expand("<cword>"))<cr>

"
" Highlight words in markdown files that should be avoided in technical documents
"
" Found in https://github.com/pengwynn/dotfiles/blob/master/vim/vimrc.symlink
" See also http://css-tricks.com/words-avoid-educational-writing/
"
"   obviously, basically, simply, of course, clearly,
"   just, everyone knows, However, So, easy
highlight TechWordsToAvoid ctermbg=red ctermfg=white
function MatchTechWordsToAvoid()
    match TechWordsToAvoid /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\)\>/
endfunction
autocmd FileType markdown call MatchTechWordsToAvoid()
autocmd BufWinEnter *.md call MatchTechWordsToAvoid()
autocmd InsertEnter *.md call MatchTechWordsToAvoid()
autocmd InsertLeave *.md call MatchTechWordsToAvoid()
autocmd BufWinLeave *.md call clearmatches()

" vim: set ts=4 sw=4 tw=78 et :
