" Custom ViM Configuration
" VERSION 1.0 (2023)
" Author: Walid Abu Al-Afia (c)

set nocompatible              " be iMproved, required
filetype off                  " required

" vim-plug
"
call plug#begin('~/.vim/plugged')

" style
Plug 'fatih/molokai'
Plug 'roosta/srcery'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-sensible'
Plug 'flazz/vim-colorschemes'
Plug 'lifepillar/vim-solarized8'
Plug 'NLKNguyen/papercolor-theme'

" google code format
Plug 'google/vim-glaive'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

" go support
Plug 'fatih/vim-go'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" racket support
Plug 'benknoble/vim-racket'

" web dev support
Plug 'mattn/emmet-vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'vim-autoformat/vim-autoformat'

" coc.nvim
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" YCM
"Plug 'Valloric/YouCompleteMe'

" tex support
Plug 'lervag/vimtex'

call plug#end()

" When edition a file, always jump to the last knows cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" |
      \ endif

syntax on

" Put the terminal back in the mode you found it upon exiting
"set t_ti= t_te=

" For DOS (and GUIs). Make the cursor a block.
set guicursor=a:hor10-blinkon0

"
" Don't use these chars to separate words.
set isk+=_,$,@,%,#,-

" Don't highlight search results (annoying)
set nohlsearch

" Highlight matching parentheses
set showmatch

" Show when in Insert mode
set showmode

" Make actions smoother
set ttyfast

" Blink the terminal instead of ringing
set vb

" Make backups
set bk
"
" Put backups in this dir
set bdir=~/.vimbackups

" Case-sensitive searches
map \ /\C
"
" Searches are incremental (like emacs)
set incsearch

" Enable vim wild menu functionality
set wildmenu
"
" Ignore certain files in the wild menu
set wildignore=*.[oa],*~
"
" Make the wild menu output long
set wildmode=list:longest

" Show cursor position and location in file
set ruler

setlocal numberwidth=3

" Make default tab size 2 spaces
set tabstop=2 
set shiftwidth=2 
set expandtab

" For tmux, use 8 space tabs
set ts=8

" Display the status line always
set ls=2

" Status line height always 2
set ch=2

" Report every change
set report=0

" Setting textwidth is obnoxious because it breaks copy-paste.
set textwidth=0

" Customize the status bar
set statusline=%-30.50(%n\ %f\ %m%h%r%w%)%l/%L\ (%p%%),\ %c\ %<%=%(\(%{bufnr(\"#\")}\ %{bufname(\"#\")})%)

" vim-formatter
let g:python3_host_prog="/usr/local/bin/python3"
"
" Use :AutoFormat or <F3> to auto format file
noremap <F3> :Autoformat<CR>
"
" Automatically auto format upon saving file
"au BufWrite * :Autoformat

" Custom autoformat per file type
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

" Do not auto-indent text files
autocmd FileType txt,vim let b:autoformat_autoindent=0
autocmd FileType tex set spell

" Remap switching between panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

set formatoptions+=t
set autoindent

" Highlight the current line when you do a search, and remove the highlight
" when the cursor moves.
hi CursorLine cterm=reverse
com! LINE :exe 'se cul'
au CursorMoved * :se nocul
au CursorMovedI * :se nocul
noremap n nzz:LINE<CR>
noremap N Nzz:LINE<CR>
noremap * *zz:LINE<CR>
noremap # #zz:LINE<CR>

" Use XTerm 256 colors
set t_Co=256

" Set the background color scheme
set background=dark
"set background=light

" COLOR SCHEME (native)
"
colorscheme solarized

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
"let g:srcery_italic = 1
"let g:srcery_bold = 1

"
" ycm
"
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" vim-go stuff
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
set updatetime=100
let g:go_auto_sameids = 1

" vim-airline theme
"let g:airline_theme='google_dark'
let g:airline_theme='monochrome'

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

" coc.nvim
"
" utf-8 byte sequence 
set encoding=utf-8

" Longer update time causes delays (default 4000 ms = 4 s)
set updatetime=300

" Always show signcolumn
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
