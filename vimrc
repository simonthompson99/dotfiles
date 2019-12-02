set nocompatible              " be iMproved, required
filetype off                  " required

""" PLUGINS
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" to interact with R
Plugin 'jalvesaq/Nvim-R'
" to view csv files nicely
Plugin 'chrisbra/csv.vim'
" more visable status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" to get nice  tab autocompletion
Plugin 'ervandew/supertab'
" handles auto-completing brackets, braces etc.
Plugin 'jiangmiao/auto-pairs'
" for changing surrounding quotes, parentheses etc.
Plugin 'tpope/vim-surround'
" for nice python indentation
Plugin 'Vimjas/vim-python-pep8-indent'
" to get hybrid line numbering, relative and absolute
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
"for moving between tmux and vim a bit more seamlessly
Plugin 'christoomey/vim-tmux-navigator'
"nerdtree plugin
Plugin 'scrooloose/nerdtree'
"send lines to a terminal
Plugin 'jalvesaq/vimcmdline'
" get solarized theme for vim
Plugin 'altercation/vim-colors-solarized'
" manage git from vim
Plugin 'tpope/vim-fugitive'
" get distraction free mode
Plugin 'junegunn/goyo.vim'
" get log file highlighting
Plugin 'mtdl9/vim-log-highlighting'
" get git changes in gutter
Plugin 'airblade/vim-gitgutter'
" show indent guides
Plugin 'nathanaelkane/vim-indent-guides'
" enable ripgrep searching from grep
Plugin 'jremmen/vim-ripgrep'
"For Snippets
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" For working with yml files
Plugin 'mrk21/yaml-vim'
" To give a handy, slimline position file position indictator in statusline
Plugin 'drzel/vim-line-no-indicator'
" All of your Plugins must be added before the following line
call vundle#end()            " required

""" VIM BEHAVIOUR
let maplocalleader="," " change the localleader from \ to ,
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
filetype plugin indent on    " allow to detect filetype and load corresponding plugins
set autochdir 	  " so that working directory changes to that for file i've opened
set cursorline    " highlight the current line
set linebreak     " to get 'soft linebreak' i.e. wrapping at word boundaries
syntax enable     " enable syntax highlighting
" Use ESC to exit insert mode in :term
tnoremap <Esc> <C-\><C-n>    
let g:airline_theme='solarized'     " set airline theme to solarized
let g:airline_solarized_bg='dark'   " set it to the dark version
let g:airline#extensions#whitespace#enabled = 0 " airline always flags mixed intent on r files which is annoying so turn this off
let g:airline_section_x = '%{&filetype}'
let g:airline_section_y = '%#__accent_bold#%{LineNoIndicator()}%#__restore__#'
let g:airline_section_z = '%2c'
set pastetoggle=<F2>     " use F2 to toggle between paste modes
" just semi-colon for doing stuff, but then double-tap to get a semi-colon
" (repeat last f or t)
map ; :
noremap ;; ;
set background=dark      " use dark background
colorscheme solarized    " use solarized colorscheme
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
let g:indent_guides_guide_size = 1 " get very subtle indent highlights and have it start from starup
let g:indent_guides_color_change_percent = 1
let g:indent_guides_enable_on_vim_startup = 1
nnoremap H gT     " use H to go back in tabs
nnoremap L gt     " use L to go forward in tabs
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR> " use leader-zz to focus cursor in the middle of the screen
set scrolloff=999 		 " by default have cursor in the middle of the screen
let g:csv_nomap_cr = 1   " prevent csv plugin from remapping control keys
nnoremap <Leader>b :ls<CR>:b<Space> 
" allows <Leader>b to accept the number of a buffer afterwards to select that buffer
nnoremap <Leader>nt :NERDTree<CR>
" remaps leader nt to opening up NERD tree
let NERDTreeShowHidden=1 " show hidden files in NERDTRee
" UltiSnips Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
 " Create Blank Newlines and stay in Normal mode
nnoremap zj o<Esc>k
nnoremap zk O<Esc>j

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

""" git remaps
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gp :Gpush<CR>

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

""" VIM ALIASES
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

""" VIM-R COMMANDS
let R_assign_map = ";"  " get <- with a double-tap on semi-colon
let R_df_viewer = "wrangleR::rdtv(%s)"  " change the data viewer to be rdtv function in wrangleR
"to show head of the df under cursor
nmap <silent> <LocalLeader>h :call RAction("head")<CR>
"to view with dtv whole of df under cursor
nmap <silent> <LocalLeader>dv :call RAction("wrangleR::dtv")<CR>
"to get glimpse of the df
nmap <silent> <LocalLeader>g :call RAction("dplyr::glimpse")<CR>
"to get number of rows in df
nmap <silent> <LocalLeader>nr :call RAction("nrow")<CR>
let R_rcomment_string = "#-- "          " change what gets added as a comment character
"enable folding but open unfolded
let r_syntax_folding = 1
set nofoldenable

""" VIM TEMPLATES
"setup templates
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.rmd 0r ~/.vim/templates/skeleton.rmd
    autocmd BufNewFile *.r 0r ~/.vim/templates/skeleton.r
    autocmd BufNewFile *.R 0r ~/.vim/templates/skeleton.r
    autocmd BufNewFile *.Rmd 0r ~/.vim/templates/skeleton.rmd
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
  augroup END
endif
