set nocompatible              " be iMproved, required
filetype off                  " required

""" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
" to view csv files nicely
Plug 'chrisbra/csv.vim'
" " more visable status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" To give a handy, slimline position file position indictator in statusline
Plug 'drzel/vim-line-no-indicator'
" for changing surrounding quotes, parentheses etc.
Plug 'machakann/vim-sandwich'
" auto closing of brackets etc.
Plug 'jiangmiao/auto-pairs'
" for nice python indentation
Plug 'Vimjas/vim-python-pep8-indent'
" to get hybrid line numbering, relative and absolute
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" for moving between tmux and vim a bit more seamlessly
Plug 'christoomey/vim-tmux-navigator'
"send lines to a terminal
Plug 'kassio/neoterm'
" get Nord colorscheme
Plug 'arcticicestudio/nord-vim'
" manage git from vim
Plug 'tpope/vim-fugitive'
" get distraction free mode
Plug 'junegunn/goyo.vim'
" get log file highlighting
Plug 'mtdl9/vim-log-highlighting'
" get git changes in gutter
Plug 'airblade/vim-gitgutter'
" show indent guides
Plug 'nathanaelkane/vim-indent-guides'
" enable ripgrep searching from grep
Plug 'jremmen/vim-ripgrep'
" show linting
Plug 'dense-analysis/ale'
" use snippets
Plug 'honza/vim-snippets'
" load language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tabnine', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-r-lsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets' ", {'do': 'yarn install --frozen-lockfile'}
" For working with yml files
Plug 'mrk21/yaml-vim'
" for makign comments
Plug 'tpope/vim-commentary'
" extend netrw a bit more
Plug 'tpope/vim-vinegar'
call plug#end()

""" VIM BEHAVIOUR
set hidden        " allow unsaved buffers to be hidden
let mapleader=" " " change the localleader from \ to ,
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set expandtab     " expand the tab to spaces
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase smartcase    " ignore case when searching, but become case-sensitive when uppercase is present
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set wildmenu " have a menu for file matches
set path+=** " include subfolders in file finding
set wildignore=*.swp,*.bak,*.pyc,*.class " ignore these files when globbing
set linebreak     " to get 'soft linebreak' i.e. wrapping at word boundaries
set showbreak=↪   " character to use for soft linebreaks
set splitbelow splitright " Split window below/right when creating horizontal/vertical windows
set noswapfile " don't create swap file
set colorcolumn=80 " Set a ruler at column 80, see https://stackoverflow.com/q/2447109/6064933
set scrolloff=999 		 " by default have cursor in the middle of the screen
set cmdheight=2 " Better display for messages
set pastetoggle=<F2>     " use F2 to toggle between paste modes
set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns
set termguicolors " see https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6

" Random settings
syntax enable     " enable syntax highlighting
filetype plugin indent on    " allow to detect filetype and load corresponding plugins
tnoremap <Esc> <C-\><C-n>    " Use ESC to exit insert mode in :term
colorscheme nord    " use nord colorscheme
let g:csv_nomap_cr = 1   " prevent csv plugin from remapping control keys
let g:rg_derive_root='true' " allow ripgrep to be able to work out the root directory of the repo

" enable spell only if file type is normal text
" stolen from https://github.com/Blacksuan19/init.nvim/blob/master/init.vim
let spellable = ['markdown', 'gitcommit']
autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='nord'     " set airline theme to nord
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'     " set airline theme to solarized
let g:airline_theme='nord'     " set airline theme to nord
let g:airline#extensions#whitespace#enabled = 0 " airline always flags mixed intent on r files which is annoying so turn this off
let g:airline_section_x = '%{&filetype}'
let g:airline_section_y = '%#__accent_bold#%{LineNoIndicator()}%#__restore__#'
let g:airline_section_z = '%2c'

" Indent guide settings
let g:indent_guides_guide_size=1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=Black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=DarkBlue

" neoterm settings
let g:neoterm_default_mod='belowright' " open terminal in bottom split
let g:neoterm_size=16 " terminal split size
let g:neoterm_autoscroll=1 " scroll to the bottom when running a command
let g:neoterm_repl_r='radian'

" set location for neovim python 3
let g:python3_host_prog="~/.pyenv/versions/neovim/bin/python"

" COC VIM Configuration
" use <tab> for trigger completion and navigate to the next complete item
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" ALE Linter configuration
" set up linters
let g:ale_fixers = {
  \ 'python': ['pylint'] ,
  \ }

" Goyo Configuration
" customise Goyo so that move down line by line
function! s:goyo_enter()
  nnoremap j gj
  nnoremap k gk
endfunction

function! s:goyo_leave()
  nunmap j
  nunmap k
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"" VIM ALIASES
command Projects cd ~/Documents/Projects
command Scratch cd ~/scratch

""" VIM FUNCTIONS
" function to see difference compared to last saved version
" call it with :DiffSaved and turn it off with :diffoff
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" function to surround lines in a selection (or defaults to whole file) with a 
" prefix and a suffic
function! SurroundLines(startline, endline) " exclamation point overwrites any existing function of same name with this one
    call inputsave() " need inputsave and inputrestore so vim knows to capture keystrokes
    let pref = input('Enter Prefix: ')
    let suff = input('Enter Suffix: ')
    call inputrestore()
    "\= is the way to refer to a variable
    exe a:startline.','.a:endline.'s/^/\=pref' 
    exe a:startline.','.a:endline.'s/$/\=suff'
endfunction

" now need to add new command to call the function, % default argument in
" range gives default of 1,$, <line1> and <line2> are escape sequences for
" start and end of selection
com! -range=% SurroundLines call SurroundLines(<line1>, <line2>)

""" VIM TEMPLATES
"setup templates
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.rmd 0r ~/.vim/templates/skeleton.rmd
    autocmd BufNewFile *.r 0r ~/.vim/templates/skeleton.r
    autocmd BufNewFile *.R 0r ~/.vim/templates/skeleton.r
    autocmd BufNewFile *.Rmd 0r ~/.vim/templates/skeleton.rmd
    autocmd BufNewFile *.md 0r ~/.vim/templates/skeleton.md
  augroup END
endif


"""REMAPS
" use semi-colon to get to command
nnoremap ; :
xnoremap ; :

" use H and L to go forward and back in tabs
nnoremap H gT     " use H to go back in tabs
nnoremap L gt     " use L to go forward in tabs

" use leader-zz to focus cursor in the middle of the screen
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR> 

" to take care of bracket autocompletion
" see https://stackoverflow.com/a/34992101
""inoremap " ""<left>
""inoremap ( ()<left>
""inoremap (<CR> (<CR>)<ESC>O
""inoremap [ []<left>
""inoremap { {}<left>
""inoremap {<CR> {<CR>}<ESC>O

" Yank from current cursor position to the end of the line (make it
" consistent with the behavior of D, C)
nnoremap Y y$

" show the full filepath with leader-fp
nnoremap <Leader>fp :echo expand("%:p")<cr>

" Continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://superuser.com/q/310417/736190
xnoremap < <gv
xnoremap > >gv

" Edit and reload init.vim quickly
nnoremap <silent> <leader>ev :edit $HOME/.vimrc<cr>
nnoremap <silent> <leader>sv :silent update $MYVIMRC <bar> source $MYVIMRC <bar>
    \ echomsg "Nvim config successfully reloaded!"<cr>

" copy filename, relative path, full path, and directory to system clipboard
" relative path  (src/foo.txt)
nnoremap <leader>cfr :let @+=expand("%")<CR>
" absolute path  (/something/src/foo.txt)
nnoremap <leader>cfp :let @+=expand("%:p")<CR>
" filename       (foo.txt)
nnoremap <leader>cff :let @+=expand("%:t")<CR>
" directory name (/something/src)
nnoremap <leader>cfd :let @+=expand("%:p:h")<CR>

" leader n will remove hightlights
nnoremap <Leader>n :noh<CR>

" use leader b to get list of buffers to choose from, and hh and ll to go up
" and down buffers
nnoremap <Leader>b :ls<CR>:b<Space> 
nnoremap <Leader>hh :bprevious<CR>
nnoremap <Leader>ll :bnext<CR>

" Create Blank Newlines and stay in Normal mode
nnoremap zj o<Esc>k
nnoremap zk O<Esc>j

" remap ripgrep to <leader> ps (project search)
nnoremap <Leader>ps :Rg<SPACE>

" remaps leader-qn and qp for quickfix list navigation
nnoremap <leader>qn :cn<CR>
nnoremap <leader>qp :cp<CR>

" Use ep error-prev and en error-next to navigate diagnositics
nnoremap <leader>ep <Plug>(coc-diagnostic-prev)
nnoremap <leader>en <Plug>(coc-diagnostic-next)

" Remap keys for gotos, 'major mode' commands 
nnoremap <leader>md <Plug>(coc-definition)
nnoremap <leader>mt <Plug>(coc-type-definition)
nnoremap <leader>mi <Plug>(coc-implementation)
nnoremap <leader>mr <Plug>(coc-references)

" Use ms for show documentation in preview window
nnoremap <leader>ms :call <SID>show_documentation()<CR>
"
" Remap for rename current word
nnoremap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xnoremap <leader>fm  <Plug>(coc-format-selected)
nnoremap <leader>fm  <Plug>(coc-format-selected)

" Remaps for working with a terminal
nnoremap <leader>s :Tnew<cr> " open new terminal
nnoremap <leader>q :Tclose!<cr> " close terminal
nnoremap <leader><cr> :TREPLSendLine<cr>j " send current line and move down
vnoremap <leader><cr> :TREPLSendSelection<cr> " send current selection
nnoremap <leader>pp vip:TREPLSendSelection<cr>} " send current paragraph and move down
nnoremap <leader>aa ggVG:TREPLSendSelection<cr>gg " send whole file

" Fugitive configuration
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gp :Gpush<CR>

" Snippet commands
" Use <C-S-l> for trigger snippet expand.
" imap <C-S-l> <Plug>(coc-snippets-expand)
" Use <C-S-j> for select text for visual placeholder of snippet.
vmap <C-S-j> <Plug>(coc-snippets-select)
" Use <C-S-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-S-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-S-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-S-j> <Plug>(coc-snippets-expand-jump)
