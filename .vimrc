set encoding=utf-8
set fileencodings=utf-8
set nowritebackup
set nobackup
set virtualedit=block
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
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

nnoremap <C-T> :NERDTreeToggle<CR>

syntax on

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
