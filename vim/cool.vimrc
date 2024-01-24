set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Style
Plugin 'tpope/vim-sensible'
Plugin 'lifepillar/vim-solarized8'
Plugin 'morhetz/gruvbox'
Plugin 'fatih/molokai'

" Google code format
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

" Go support
Plugin 'fatih/vim-go'

" YCM
Plugin 'Valloric/YouCompleteMe'

" tex support
Plugin 'lervag/vimtex'

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


" END OF VUNDLE


" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif


syntax on
"
" don't use these chars to seperate words
set isk+=_,$,@,%,#,-

" highlight matching parens
set showmatch

set wildmenu
set wildignore=*.o,*~
set wildmode=longest,list

set number
set ruler
setlocal numberwidth=3
set tabstop=2 shiftwidth=2 expandtab

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

autocmd FileType tex set spell

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer autopep8
  " Alternative: autocmd FileType python AutoFormatBuffer yapf
augroup END

" gui stuff
" if has('gui')
" 	set guioptions-=m
" 	set guioptions-=T
" 	set guioptions-=l
" 	set guioptions-=L
" 	set guioptions-=r
" 	set guioptions-=R
"     set guifont=Source\ Code\ Pro\ Light:h12
"     colors wombat
"     set rnu
"     "set transp=8
" end

set textwidth=80
set formatoptions+=t
set autoindent

" Style
" https://tomlankhorst.nl/iterm-tmux-vim-true-color/
" set Vim-specific sequences for RGB colors
" set t_Co=256
" set termencoding=utf-8
" set guioptions=eg

set background=dark
" colorscheme inkpot
colorscheme gruvbox
let g:gruvbox_italic=1
" colorscheme flattened_dark
" let g:solarized_termcolors=256
" let g:solarized_termtrans = 0 
" let g:solarized_degrade = 1
" let g:solarized_bold = 1 
" let g:solarized_underline = 1 
" let g:solarized_italic = 1 
" let g:solarized_contrast = "normal"
" let g:solarized_visibility= "normal"
" colorscheme solarized8
" colors zenburn

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

let g:rehash256 = 1
" let g:molokai_original = 1
" colorscheme molokai


" vim-go stuff
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
set updatetime=100
let g:go_auto_sameids = 1

" keep source trees clean
set backupdir=~/.vimswp
set directory=~/.vimswp
set undodir=~/.vimswp

" relative line numbering
" set rnu
