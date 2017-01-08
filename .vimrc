set nocompatible
"let g:UltiSnipsUsePythonVersion=3
" configuration for bundle {{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/vim-easy-align'
Plugin 'Raimondi/delimitMate'
Plugin 'dkprice/vim-easygrep'
Plugin 'minibufexplorerpp'
Plugin 'winmanager'
Plugin 'matchit.zip'
Plugin 'luochen1990/rainbow'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on
" }}} end of bundle
colorscheme molokai
let mapleader=","
" configuration for airline {{{
set t_Co=256
set laststatus=2
set ttimeoutlen=50
set term=xterm-256color
set termencoding=utf-8
let g:airline_left_sep=''
let g:airline_right_sep=''
" }}} end of airline
" configuration for easymotion {{{
let g:EasyMotion_space_jump_first = 1
" }}} end of easymotion
" configuration for ultisnips {{{
let g:UltiSnipsExpandTrigger='<C-L>'
" }}}
" configuration for YCM {{{
let g:ycm_confirm_extra_conf=0
" }}}
" configuration for easy align {{{
vmap    <ENTER>     <Plug>(EasyAlign)
nmap    gl          <Plug>(EasyAlign)
" }}}
" global configurations aka sets {{{
set backspace=indent,eol,start
set incsearch hlsearch
set cursorcolumn cursorline
set ts=4
set sw=4
set autoindent
set expandtab
set fdm=marker
set number
set relativenumber
set fileencodings=ucs-bom,utf-8,cp936,latin1
filetype plugin indent on
syntax on
let g:session_autosave = 'yes'
" }}} end of global conf
" CtrlP config {{{
set wildignore+=*.so,*.swp,*.zip
" }}} end of CtrlP
"set makeprg=mingw32-make.exe
" Maps: {{{
nnoremap <Leader>ww	    :w<CR>
nnoremap <Leader>ee	    :e ~/.vimrc<CR>
nnoremap <Leader>src    :source ~/.vimrc<CR>
nnoremap <Leader>q      :q<CR>
nnoremap <Leader>qa     :qa<CR>

""nnoremap <Leader>bl	:blast<CR>
""nnoremap <Leader>bn	:bnext<CR>
""nnoremap <Leader>bp	:bprev<CR>
""nnoremap <Leader>bf	:bfirst<CR>
""nnoremap <Leader>bc	:bunload<CR>
""nnoremap <Tab>      :bnext<cr>
""nnoremap <S-Tab>    :bprev<cr>
nnoremap <Leader>nh :nohl<CR>

"resize window size
nnoremap <Leader>r= :resize +3<cr>
nnoremap <Leader>r- :resize -3<cr>
nnoremap <Leader>vr= :vertical resize +3<cr>
nnoremap <Leader>vr- :vertical resize -3<cr>

nnoremap <Leader>fs A//{{{<esc>
nnoremap <Leader>fe A//}}}<esc>

nnoremap w    :w<CR>
nnoremap <Leader>h  <C-W>h
nnoremap <Leader>j  <C-W>j
nnoremap <Leader>k  <C-W>k
nnoremap <Leader>l  <C-W>l
nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprev<CR>
nnoremap <Leader>tl :tablast<CR>
nnoremap <Leader>tf :tabfirst<CR>
" map F12 for python run
noremap  <F12>      :!python3 %<CR>
noremap! <F12>      <ESC>:w<CR>:!python3 %<CR> 
" }}} end of Maps
inoremap (  ()<Left>
inoremap [  []<Left>
inoremap {  {}<Left>
"}])
inoremap "  ""<Left>

unlet mapleader

function! OpenNERDTree()
    if !empty(expand("%")) && expand("%") !~ "NERD"
        cd %:p:h
    endif
    NERDTree
endfunction

nnoremap <F3>   :call OpenNERDTree()<CR>
nnoremap <F2>   :TagbarToggle<CR>
" configuration for cscope {{{
" cscope key maps
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nnoremap    <F5>    :call BuildCscopeDatabase(0)<CR>
nnoremap    <S-F5>  :call BuildCscopeDatabase(1)<CR>

function! FindCSDB()
    let csdb=findfile('cscope.out',';')    
    if csdb == 'cscope.out'
        let csdb=getcwd() . '/cscope.out'
    endif
    return csdb
endfunction
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    let csdb=FindCSDB()
    if !empty(csdb)
        exec "cs add " . csdb . " ". substitute(csdb, '/cscope.out$', '', '')
    endif
    set csverb
endif

function! BuildCscopeDatabase(rebuild)
    let csdb=FindCSDB()
    let cwd=getcwd()
    if !empty(csdb)
        exec "cs kill " . csdb
        exec "cd " . substitute(csdb, '/cscope.out$', '', '')
    endif
    if empty(csdb) || a:rebuild == 1
        call delete('cscope.out')
        silent !cscope -Rb
    endif
    exec "cs add cscope.out " . getcwd()
    exec "cd " . cwd
endfunction
" }}} end of cscope

function! EditForGTEST()
    let delete_lines="SourcePrefix.h\\|CExampleTest.h\\|CPPUNIT_TEST\\|setUp\\|tearDown"
    %s/void \(.*\)::\(.*\)()/TEST(\1,\2)/g
    %s/CPPUNIT_ASSERT/EXPECT_TRUE/g
    exec "g/" . delete_lines . "/d"
    norm ggO#include "gtest/gtest.h
endfunction

" autocmd for different file types {{{
augroup FTAUGRP
    au!
    " python & Makefile files no expand tab "
    au FileType python,make     set noet | set ts=4
    au FileType c,cc,cpp        set cindent
augroup END
" }}}
""let Tlist_Show_One_File=0                    " 只显示当前文件的tags
""let Tlist_Exit_OnlyWindow=1                  " 如果Taglist窗口是最后一个窗口则退出Vim
""let Tlist_Use_Right_Window=1                 " 在右侧窗口中显示
""let Tlist_File_Fold_Auto_Close=1             " 自动折叠
" vim:ts=4:sw=4:ft=vim:
