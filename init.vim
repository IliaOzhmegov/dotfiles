"Plug-ins
call plug#begin('~/.config/nvim/plugged')
" Tools
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/limelight.vim'
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/nerdtree'
" For R
    Plug 'jalvesaq/Nvim-R'
    " assuming you're using vim-plug: https://github.com/junegunn/vim-plug
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'gaalcaras/ncm-R'
        " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect

    " NOTE: you need to install completion sources to get completions. Check
    " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
" Syntax
    Plug 'tpope/vim-markdown'
    Plug 'ap/vim-css-color' "Displays a preview of colors with CSS 
    Plug 'vim-scripts/fountain.vim'
" Color-schemes
    Plug 'morhetz/gruvbox' "My favorite theme
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'ajh17/Spacegray.vim'
    Plug 'chriskempson/base16-vim'
call plug#end() 

" basics
set encoding=UTF-8
filetype plugin indent on
syntax on 
set autoread wildmode=longest,list,full
set spell spelllang=en_us
"tnoremap <Esc> <C-\><C-n>

set number
set relativenumber

set incsearch
set ignorecase
set smartcase
set nohlsearch

set tabstop=4
set softtabstop=0
set shiftwidth=4

set expandtab
set nobackup
set noswapfile
set nowrap
set splitbelow splitright 

"Status-line
set statusline=
set statusline+=%#IncSearch#
set statusline+=\ %y
set statusline+=\ %r
set statusline+=%#CursorLineNr#
set statusline+=\ %F
set statusline+=%= "Right side settings
set statusline+=%#Search#
set statusline+=\ %l/%L
set statusline+=\ [%c]

"Color Settings
colorscheme gruvbox
set background=dark termguicolors cursorline

hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE 

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" clipboard settings
set clipboard+=unnamedplus

" others
setlocal spell spelllang=ru_yo,en_us

" Key-bindings
"let mapleader="\"

"map <leader><Space> :EditVifm .<CR>

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

map <F1> :colorscheme gruvbox<CR>
map <F2> :colorscheme base16-default-dark<CR>
map <F3> :colorscheme hybrid_reverse<CR>
map <F4> :colorscheme PaperColor<CR>
map <F5> :colorscheme spacegray<CR>

map <C-n> :NERDTreeToggle<CR>


" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })

" setting for terminal
augroup TerminalStuff
   au!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
