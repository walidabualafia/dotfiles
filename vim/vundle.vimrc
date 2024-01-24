set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" YouCompleteMe by Valloric
Plugin 'Valloric/YouCompleteMe'

" YCM Exrta Config Minimal C
Plugin 'l3nkz/ycmconf'

" vim-go by fatih
Plugin 'fatih/vim-go'

" vim-fugitive by tpope
Plugin 'tpope/vim-fugitive'

" vim-commentary by tpope
Plugin 'tpope/vim-commentary'

" vim-surround by tpope
Plugin 'tpope/vim-surround'

" vim-airline by vim-airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" syntastic by vim-syntastic
Plugin 'vim-syntastic/syntastic'

" emmet-vim by mattn
Plugin 'mattn/emmet-vim'

" vim-rainbow for cool brackets 8)
Plugin 'frazrepo/vim-rainbow'

" tagalong.vim by AndrewRadev
Plugin 'AndrewRadev/tagalong.vim'

" gruvbox by morhetz
Plugin 'morhetz/gruvbox'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
" non-Plugin stuff below this line:

" Make colorscheme delek
"autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

" Set indentation to 4 spaces
set shiftwidth=2
set autoindent
set smartindent

" Turn on syntax highlighting.
syntax on

" Automatically wrap text that extends beyond the screen.
set wrap

" Speed up scrolling.
set ttyfast

" Status bar.
set laststatus=2

" Highlight matching pairs of brackets. Use the '%' char to jump between them.
set matchpairs+=<:>

" Show hybrid line numbers.
set number relativenumber

" Toggle relative and line number
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Display options.
set showmode
set showcmd

" Enable auto completion menu after pressing tab 
set wildmenu

" Make wildmenu behave similar to bash completion
set wildmode=list:longest

" Wildmenu ignore files
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*img,*xlsx

" Set highlight search and incsearch
set hls is

" Set colors for airline
set t_Co=256
let g:airline_theme='base16color'
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" to enable vim-rainbow for html,css
"au FileType html,css call rainbow#load()
" if want to enable globally
"let g:rainbow_active = 1

" emmet config
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" tag-along config
let g:tagalong_filetypes = ['html', 'css', 'js']

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
