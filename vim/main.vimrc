" Custom ViM Configuration
" VERSION 1.0 (2023)
" Author: Walid Abu Al-Afia (c)

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" style
Plugin 'roosta/srcery'
Plugin 'tpope/vim-sensible'
Plugin 'flazz/vim-colorschemes'
Plugin 'NLKNguyen/papercolor-theme'

" google code format
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'

" go support
Plugin 'fatih/vim-go'

" racket support
Plugin 'benknoble/vim-racket'

" web dev support
Plugin 'mattn/emmet-vim'
Plugin 'AndrewRadev/tagalong.vim'
Plugin 'vim-autoformat/vim-autoformat'

" YCM
Plugin 'Valloric/YouCompleteMe'

" tex support
Plugin 'lervag/vimtex'

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

set wildmenu
set wildignore=*.o,*~
set wildmode=longest,list

set number
set ruler
setlocal numberwidth=3
set tabstop=2 shiftwidth=2 expandtab

set laststatus=2

" vim-formatter
noremap <F3> :Autoformat<CR>
au BufWrite * :Autoformat

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

autocmd FileType tex set spell

set textwidth=80
set formatoptions+=t
set autoindent

set t_Co=256
colorscheme srcery

" 256_noir
"set cursorline
"highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
"autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1c1c1c
"autocmd InsertLeave * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212

" gruvbox
"let g:gruvbox_italic=1
"
"let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"set termguicolors

" molokai
"let g:rehash256 = 1

" srcery
let g:srcery_italic = 1
let g:srcery_bold = 1

" vim-go stuff
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
set updatetime=100
let g:go_auto_sameids = 1

" Emmet config
"
" enable all functions
let g:user_emmet_mode='inv'
"
" only enable in html and css
let g:user_emmet_install_global=0
autocmd FileType html,css,js EmmetInstall
"
" rebind action key
let g:user_emmet_leader_key=','

let g:tagalong_verbose=1

" keep source trees clean
set backupdir=~/.vimswp
set directory=~/.vimswp
set undodir=~/.vimswp

" show hybrid line numbers.
set number relativenumber

" toggle relative and line number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Custom autoformat
"
"augroup autoformat_settings
"    autocmd FileType bzl AutoFormatBuffer buildifier
"    autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
"    autocmd FileType dart AutoFormatBuffer dartfmt
"    autocmd FileType go AutoFormatBuffer gofmt
"    autocmd FileType gn AutoFormatBuffer gn
"    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
"    autocmd FileType java AutoFormatBuffer google-java-format
"    autocmd FileType python AutoFormatBuffer autopep8
"augroup END
