set encoding=utf-8
set fileencodings=utf-8
set nowritebackup
set nobackup
set virtualedit=block
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set wildmode=full
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set noerrorbells
set shellslash
set showmatch matchtime=1
set cinoptions+=:0
set cmdheight=2
set laststatus=2
set display=lastline
set list
set listchars=tab:^\ ,trail:~
set history=10000
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set guioptions-=T
set guioptions+=a
set guioptions-=m
set guioptions+=R
set showmatch
set smartindent
set noswapfile
set nofoldenable
set title
set number
set clipboard=unnamed,autoselect
set nrformats=

nnoremap <C-T> :NERDTreeToggle<CR>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'dense-analysis/ale'
NeoBundle 'jacoborus/tender.vim'
call neobundle#end()

filetype plugin indent on
NeoBundleCheck

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme tender

let g:ale_linters = {
      \ 'ruby': ['rubocop'],
      \ }
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
