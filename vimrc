set nocompatible

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

syntax on
set t_Co=256
set background=dark
set modeline
set number
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set encoding=utf8
set nohlsearch
set ruler
set incsearch
set ignorecase
set backspace=start,indent,eol
set noswapfile
set autowrite "Save on buffer switch
set undolevels=100
set hidden
set mouse=a
set cm=blowfish
set wildignore+=*/.git/*,*/vendor/*
set clipboard=unnamedplus
set listchars=tab:>-,trail:.,extends:>,precedes:<
set list
set laststatus=2

let mapleader = ","

"-------------------------------------------------
"  Load plugins by vundle
"-------------------------------------------------

filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'DataWraith/auto_mkdir.git'
Bundle 'airblade/vim-gitgutter.git'
Bundle 'kovagoz/vim-autocomplpop'
Bundle 'L9'
Bundle 'matchit.zip'
Bundle 'xsbeats/vim-blade.git'
Bundle 'puppetlabs/puppet-syntax-vim.git'
Bundle 'terryma/vim-multiple-cursors.git'
Bundle 'hallison/vim-markdown.git'
Bundle 'nextval'
Bundle 'mattn/emmet-vim.git'

" Snippets
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"

Bundle "markwu/vim-laravel4-snippets"
autocmd FileType php set ft=php.laravel

Bundle 'chilicuil/vim-sprunge'
nnoremap <Leader>y :Sprunge<CR>
vnoremap <Leader>y :Sprunge<CR>

Bundle 'sjl/badwolf.git'
silent! colorscheme badwolf

Bundle 'kien/ctrlp.vim.git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20'
let g:ctrlp_map = '<c-f>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ }
nnoremap <c-b> :CtrlPBuffer<CR>
nnoremap <c-t> :CtrlPBufTag<CR>

Bundle 'scrooloose/nerdtree.git'
nnoremap <Leader>o :NERDTreeToggle<CR>

Bundle 'tpope/vim-fugitive.git'
let g:fugitive_git_executable = 'git -c color.status=false'
nnoremap <Leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR><C-w>20+
nnoremap <leader>gc :Gcommit<CR>

Bundle 'tomtom/tcomment_vim.git'
nmap <Leader>cc gcc
vmap <Leader>cc gc

Bundle 'sjl/gundo.vim'
nnoremap <leader>u :GundoToggle<CR>

" Bundle 'phpfolding.vim'
" let g:DisableAutoPHPFolding = 1
" nnoremap zf :EnablePHPFolds<CR>zr

Bundle 'Align'
vnoremap aa :Align =><CR>
vnoremap ae :Align =<CR>

Bundle 'kwbdi.vim'
map <Leader>x <Plug>Kwbd

Bundle 'scrooloose/syntastic.git'
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_phpcs_disable = 1
let g:syntastic_mode_map = {'mode': 'active', 'active_filetypes': ['php']}
let g:syntastic_php_checkers=['php']

Bundle 'joonty/vdebug.git'
let g:vdebug_options = { 'break_on_open': 0, 'port': 9000 }
nmap <Leader>bp <F10>

filetype plugin indent on

"-------------------------------------------------
"  Custom shortcuts
"-------------------------------------------------

" switch between buffers
noremap <silent> <Left>  :bNext<CR>
noremap <silent> <Right> :bnext<CR>

" Run PHP from Vim
autocmd FileType php noremap <C-M> :w!<CR>:!clear;/usr/bin/php %:p<CR>

" Always open quickfix window at the bottom of layout
autocmd FileType qf wincmd J

" Automatically reload vimrc after save and close
autocmd bufwritepost .vimrc source $MYVIMRC

" Save as root
cnoremap w!! w !sudo tee % >/dev/null

" Redefine arrow keys
noremap <Up>   <C-Y>
noremap <Down> <C-E>

" Highlight nothing
nnoremap <Leader><space> :noh<cr>

" Toggle paste mode
nnoremap <Leader>p :set invpaste paste?<CR>

" Simulate function keys
map <Leader>1 <F1>
map <Leader>2 <F2>
map <Leader>3 <F3>
map <Leader>4 <F4>
map <Leader>5 <F5>
map <Leader>6 <F6>
map <Leader>7 <F7>
map <Leader>8 <F8>
map <Leader>9 <F9>
map <Leader>10 <F10>
map <Leader>11 <F11>
map <Leader>12 <F12>

" Select pasted text
nnoremap <leader>v V`]

" Toggle numbers
nnoremap <leader>n :set nonumber!<CR>

" Switch windows with Shift+Arrow keys
map <Esc>[1;2A <S-Up>
map <Esc>[1;2B <S-Down>
map <Esc>[1;2C <S-Right>
map <Esc>[1;2D <S-Left>
map <S-Up> :lprev<CR>
map <S-Down> :lnext<CR>
map <S-Right> <C-W>w
map <S-Left> <C-W>W

" Wrap visual block with 'if' statement
au FileType php vmap <Leader>if S{$iif () <Esc>hi

" Retab (convert tabs to spaces)
nnoremap <Leader>rt :%s/\t/    /g<CR>
vnoremap <Leader>rt :s/\t/    /g<CR>

" PHP docblock generator
au FileType php nmap <Leader>db :%!php ~/.vim/scripts/docblock.php<CR>

nnoremap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"------------------------------------------------------------------------------
" Refactor PHP function
"------------------------------------------------------------------------------

fu! RefactorFunction() range
    let funcname = input("New function name: ")
    execute a:firstline . "," . a:lastline . "delete"
    execute "normal! O$this->" . funcname . "();"
    execute "normal! ]}o\rprivate function " . funcname . "()\r{\r}"
    normal! P
endfunc

au FileType php vnoremap <Leader>rf :call RefactorFunction()<CR>

"------------------------------------------------------------------------------
" Refactor PHP variable
"------------------------------------------------------------------------------

fu! RefactorVariable() range
    let varname = input("New variable name: ")
    execute "normal! gvdi$" . varname
    execute "normal! O$" . varname . " = "
    execute "normal! pA;"
endfunc

au FileType php vnoremap <Leader>rv :call RefactorVariable()<CR>

"------------------------------------------------------------------------------
" Quickfix / location list navigation
"------------------------------------------------------------------------------

nnoremap <Leader>]  :NextError<CR>
nnoremap <Leader>[  :PrevError<CR>

com! -bar NextError  call s:GoForError("next")
com! -bar PrevError  call s:GoForError("previous")

func! s:GoForError(partcmd)
     try
         try
             exec "l". a:partcmd
         catch /:E776:/
             " No location list
             exec "c". a:partcmd
         endtry
     catch
         echohl ErrorMsg
         echomsg matchstr(v:exception, ':\zs.*')
         echohl None
     endtry
endfunc
