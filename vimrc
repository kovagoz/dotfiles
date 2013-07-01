set nocompatible

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
set wildignore+=vendor/**

"-------------------------------------------------
"  Load plugins by vundle
"-------------------------------------------------

filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround.git'
Bundle 'mileszs/ack.vim.git'
Bundle 'Lokaltog/vim-easymotion.git'
Bundle 'DataWraith/auto_mkdir.git'
Bundle 'airblade/vim-gitgutter.git'
Bundle 'kovagoz/vim-autocomplpop'
Bundle 'L9'
Bundle 'matchit.zip'

Bundle 'wincent/Command-T.git'
let g:CommandTMatchWindowAtTop = 1
nnoremap <C-t> :CommandT<CR>

Bundle 'altercation/vim-colors-solarized.git'
silent! colorscheme solarized
hi Folded cterm=None
hi SignColumn ctermbg=Black

Bundle 'scrooloose/nerdtree.git'
nnoremap <Leader>o :NERDTreeToggle<CR>

Bundle 'tpope/vim-fugitive.git'
let g:fugitive_git_executable = 'git -c color.status=false'
nnoremap <Leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR><C-w>20+

Bundle 'tomtom/tcomment_vim.git'
nmap <Leader>cc gcc
vmap <Leader>cc gc

" Bundle 'xolox/vim-easytags.git'
" let g:easytags_auto_highlight = 0

Bundle 'joonty/vim-phpqa.git'
let g:phpqa_messdetector_autorun = 0
let g:phpqa_messdetector_ruleset = "~/.vim/phpmd.xml"
let g:phpqa_codesniffer_autorun = 0
let g:phpqa_codesniffer_args = "--standard=PSR2"
let g:phpqa_codecoverage_autorun = 0
nnoremap <Leader>cs :Phpcs<CR>:lfirst<CR>
nnoremap <Leader>md :Phpmd<CR>:lfirst<CR>

Bundle 'sjl/gundo.vim'
nnoremap <leader>u :GundoToggle<CR>

Bundle 'phpfolding.vim'
let g:DisableAutoPHPFolding = 1
nnoremap zf :EnablePHPFolds<CR>zr

Bundle 'Align'
vnoremap aa :Align =><CR>
vnoremap ae :Align =<CR>

Bundle 'kwbdi.vim'
map <Leader>x <Plug>Kwbd

Bundle 'kovagoz/vim-fuzzyfinder'
nnoremap <Leader>/ :FufBufferTag<CR>
nnoremap <Leader>j :FufTag<CR>
nnoremap <Leader>f :FufFile<CR>
nnoremap <C-b> :FufBuffer<CR>

" Bundle 'minibufexpl.vim'
" let g:miniBufExplMoreThanOne = 1
" let g:miniBufExplModSelTarget = 0
" let g:miniBufExplUseSingleClick = 1
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplVSplit = 30
" let g:miniBufExplSplitBelow = 1
noremap <silent> <Left>  :bNext<CR>
noremap <silent> <Right> :bnext<CR>

Bundle 'scrooloose/syntastic.git'
let g:syntastic_enable_signs = 1
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_phpcs_disable = 1
let g:syntastic_mode_map = {'mode': 'passive'}
set statusline+=%{SyntasticStatuslineFlag()}

Bundle 'joonty/vdebug.git'
"let g:vdebug_options = { 'break_on_open': 0, 'port': 9001 }
let g:vdebug_options = { 'break_on_open': 0, 'port': 9001, 'server': '192.168.1.23', 'debug_file': '/tmp/vdebug.log' }
nmap <Leader>bp <F10>

filetype plugin indent on

"-------------------------------------------------
"  Custom shortcuts
"-------------------------------------------------

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

" Send selected text to pastebin.com
noremap <silent> <Leader>y :w !php ~/.vim/scripts/pastebin.php<CR>

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

"------------------------------------------------------------------------------
" PWD status plugin
" @see http://www.vim.org/scripts/script.php?script_id=3897
"------------------------------------------------------------------------------

if has('statusline')
    if version >= 700
        set laststatus=2
        set statusline=
        set statusline+=%#MyColor1#
        set statusline+=%n                   " buffer number
        set statusline+=%#MyColor2#
        set statusline+=%{'/'.bufnr('$')}\   " total buffers
        set statusline+=%#MyColor3#
        set statusline+=%<%1.30{getcwd()}\ \ " pwd
        set statusline+=%#MyColor1#
        set statusline+=%<%1.50f             " filename
        set statusline+=%#MyColor3#
        set statusline+=\ %y%h%w             " filetype, help, example flags
        set statusline+=%#MyColor4#
        set statusline+=%r%m                 " read-only, modified flags
        set statusline+=%#MyColor3#
        set statusline+=%=\                  " indent right
        set statusline+=%#MyColor1#
        set statusline+=%l                   " line number
        set statusline+=%#MyColor2#
        set statusline+=/%{line('$')}        " total lines
        set statusline+=%#MyColor2#
        set statusline+=,
        set statusline+=%#MyColor1#
        set statusline+=%c%V                 " [virtual] column numberV
        set statusline+=%#MyColor2#
        set statusline+=\                    "
        set statusline+=%#MyColor3#
        set statusline+=%<%P                 " percent
        highlight MyColor1 guifg=#fff guibg=#00a ctermfg=white   ctermbg=darkgray
        highlight MyColor2 guifg=#aaa guibg=#007 ctermfg=gray    ctermbg=darkgray
        highlight MyColor3 guifg=#7f7 guibg=#007 ctermfg=black   ctermbg=darkgray
        highlight MyColor4 guifg=#ff0 guibg=#905 ctermfg=magenta ctermbg=darkgray
    endif
endif
