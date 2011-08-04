set runtimepath+=~/.vim/vim-addon-manager

"" have the mouse enabled all the time:
set mouse=a
set ruler
set number
 
set bg=dark

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.pyc,*.svn,*.png,*.jpg,*.gif,*.pdf,*.bak,*.lo

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" remove the Toolbar in MacVim
set guioptions-=T
colorscheme slate

" highlight the searchresults
set hlsearch
" start selection on shift and with the mouse
set selectmode=mouse,key

" use indents of 4 spaces, and have them copied down lines:
set shiftwidth=4
set shiftround
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set textwidth=79
set smartindent
set nocompatible
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000	

" disable autowrap
set tw=0
set nowrapscan
set nowrap
set linebreak " wrap on word boundaries, not right in the middle of a word
"line wrapping cursor
set whichwrap=<,>,h,l,[,]

" make sidescroll smoother
set sidescroll=3
" center the cursors on scrolling sidewards
set sidescrolloff=3
set backupdir=/tmp   
set directory=/tmp " Don't clutter my dirs up with swp and tmp files
set scrolloff=3 " keep 3 lines visible at top and bottom 

" undoinng even after closing the file
set undofile
set undodir=~/.vim/undo
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

syntax on
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

filetype on
filetype plugin on
" filetype indent off
" filetype plugin indent off

let NERDTreeIgnore=['\.pyc$', '\~$', '^\.svn', '\.o$', '\.aux$', '\.out$', '\..*\.orig$', '\.synctex.gz$', '\.toc$', '\.blg$', '\.bbl', '\.lof', '\.lot']

" enable rsense ruby completion
let g:rsenseUseOmniFunc = 1
let g:rsenseHome = "/opt/rsense-0.3"

" enable gcc sense completion
let g:gccsenseUseOmniFunc = 1

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null" 

" syntax coloring for pinocchio
au BufNewFile,BufRead *.p setlocal filetype=scheme

" ctags
set tags+=$HOME/.vim/tags/python.ctags

" define `Ispell' language and personal dictionary, used in several places
" below:
set spell
let IspellLang = 'british'
let PersonalDict = '~/.ispell_' . IspellLang
let g:languagetool_jar='/opt/share/LanguageTool-1.3.1/LanguageTool.jar'

" correct my common typos without me even noticing them:
abbreviate teh the
abbreviate notificaiton notification

" mark character exceeding the 80 limit as errors
" match Error /\%>80v/

" FileTypes ==================================================================
" autowrap for .txt and .tex files
autocmd FileType tex setlocal wrap spell
autocmd BufRead,BufNewFile *.txt setlocal wrap spell
autocmd BufRead,BufNewFile *.md setlocal wrap spell

" latex suite settings =======================================================
let g:Tex_DefaultTargetFormat = 'pdf'
 
let g:Tex_CompileRule_dvi         = 'latex --interaction=nonstopmode $*'
let g:Tex_CompileRule_ps          = 'dvips -Pwww -o $*.ps $*.dvi'
let g:Tex_CompileRule_pspdf       = 'ps2pdf $*.ps'
let g:Tex_CompileRule_dvipdf      = 'dvipdfm $*.dvi'
let g:Tex_CompileRule_pdf         = 'trex $* || pdflatex -synctex=1 -interaction=nonstopmode $*'
 
let g:Tex_ViewRule_dvi            = 'texniscope'
let g:Tex_ViewRule_ps             = 'Preview'
let g:Tex_ViewRule_pdf            = 'Skim'
 
let g:Tex_FormatDependency_ps     = 'dvi,ps'
let g:Tex_FormatDependency_pspdf  = 'dvi,ps,pspdf'
let g:Tex_FormatDependency_dvipdf = 'dvi,dvipdf'


" arrow mapping ===============================================================
" arrows shouldn't jump over wrapped lines
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap <buffer> <silent> <Home> g<Home>
nnoremap <buffer> <silent> <End>  g<End>

vnoremap <Down> gj
vnoremap <Up> gk
vnoremap <buffer> <silent> <Home> g<Home>
vnoremap <buffer> <silent> <End>  g<End>

inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End> <C-o>g<End>


"" key mappings ===============================================================

command Q q " Bind :Q to :q

" directly jump to edit mode from visual mode
vmap i <ESC>i
vmap o <ESC>o
vmap a <ESC>a
vmap A <ESC>A
" eclipse whuwhu style autocompletion
imap <C-SPACE> <C-p>
"imap <C-]> <ESC><C-]>i
"map  <C-[> <C-t>
"imap <C-[> <ESC><C-t>i
imap <D-.> <ESC>:


"" Code folding
set foldmethod=syntax
set nofoldenable
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""
map  <C-LEFT>  <ESC>zc
imap <C-LEFT>  <ESC>zci
map  <C-RIGHT> <ESC>zo
imap <C-RIGHT> <ESC>zoi


" enable terminal like per line jumping
map  <C-e> <ESC>$
imap <C-e> <ESC>A
map  <C-a> <ESC>^
imap <C-a> <ESC>^i
imap <C-k> <ESC>Di
map  <C-k> <ESC>D

" directly jump into visual block mode from insert mode
imap <C-v> <ESC><C-v>

"AlignCtrl l:
vmap <C-A> :Align=<CR> 
