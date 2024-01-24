set nocompatible              " be iMproved, required
filetype off                  " required

" vim-plug
"
" VIM
"call plug#begin('~/.vim/plugged')
"
" NEOVIM
call plug#begin('~/.config/nvim/plugged')

" Style
Plug 'tpope/vim-sensible'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'fatih/molokai'
Plug 'srcery-colors/srcery-vim'
Plug 'NLKNguyen/papercolor-theme'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Google code format
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" tex support
Plug 'lervag/vimtex'

call plug#end()

" For all text files set 'textwidth' to 78 characters.
autocmd FileType  text setlocal textwidth=78

" When edition a file, always jump to the last knows cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" |
      \ endif

syntax on
"
" don't use these chars to separate words.
set isk+=_,$,@,%,#,-

" highlight matching parens
set showmatch

" set utf-8
set encoding=utf-8

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
augroup END

set textwidth=80
set formatoptions+=t
set autoindent

set t_Co=256

set background=dark
" colorscheme inkpot
colorscheme srcery 

" srcery
let g:srcery_italic=1
let g:srcery_bold=1
let g:srcery_underline=1
let g:srcery_undercurl=1
let g:srcery_italic_types=1
let g:srcery_inverse_matches=1

" gruvbox
"let g:gruvbox_italic=1

"let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"set termguicolors

" molokai
"let g:rehash256 = 1

" vim-airline
let g:airline_theme='google_dark'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

"vim-go stuff
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
set updatetime=100
let g:go_auto_sameids = 1

" keep source trees clean
set backupdir=~/.vimswp
set directory=~/.vimswp
set undodir=~/.vimswp

" Show hybrid line numbers.
set number relativenumber

" Toggle relative and line number
augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

