let SCRIPT_DIR=expand('~/vimrc/vimscripts/')
silent! exec 'source ' . SCRIPT_DIR . 'bundle_me.vim'
silent! exec 'source ' . SCRIPT_DIR . 'swap_me.vim'

colorscheme molokai
let mapleader=","
" configuration for vimmake {{{
let g:vimmake_mode = {'make':'async', 'run':'async'}
let g:vimmake_path = expand('~') . '/vimrc'

function! OpenQuickfixSilently()
	let save_winnr = winnr()
	exec "copen"
	exec save_winnr . " wincmd w"
endfunction

noremap  <F9>        :call OpenQuickfixSilently()<cr>:VimTool make<cr>
noremap  <F10>       :call OpenQuickfixSilently()<cr>:VimTool run<cr>
inoremap <F9> 	<ESC>:call OpenQuickfixSilently()<cr>:VimTool make<cr>
inoremap <F10> 	<ESC>:call OpenQuickfixSilently()<cr>:VimTool run<cr>
" }}}
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
map s <Plug>(easymotion-s)
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
" configuration for Sessions{{{
let g:session_autoload='no'
let g:session_autosave='no'
" }}}
" global configurations aka sets {{{
scriptencoding utf-8
set backspace=indent,eol,start
set incsearch hlsearch
set cursorcolumn cursorline
set ts=4
set sw=4
set autoindent
set expandtab
set number relativenumber
set fileencodings=ucs-bom,utf-8,cp936,latin1
filetype plugin indent on
syntax on
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

nnoremap <Leader>co 	:copen<CR>
nnoremap <Leader>cc 	:cclose<CR>
""nnoremap <Leader>bl	:blast<CR>
""nnoremap <Leader>bn	:bnext<CR>
""nnoremap <Leader>bp	:bprev<CR>
""nnoremap <Leader>bf	:bfirst<CR>
""nnoremap <Leader>bc	:bunload<CR>
""nnoremap <Tab>      :bnext<cr>
""nnoremap <S-Tab>    :bprev<cr>
nnoremap n		:nohl<CR>
nnoremap <Leader>nh :nohl<CR>

"resize window size
nnoremap <Leader>r= :resize +3<cr>
nnoremap <Leader>r- :resize -3<cr>
nnoremap <Leader>vr= :vertical resize +3<cr>
nnoremap <Leader>vr- :vertical resize -3<cr>

nnoremap <Leader>fs A//{{{<esc>
nnoremap <Leader>fe A//}}}<esc>

nnoremap h 	<C-W><C-H>
nnoremap j 	<C-W><C-J>
nnoremap k 	<C-W><C-K>
nnoremap l 	<C-W><C-L>
inoremap e	A
inoremap b	I

nnoremap w    :w<CR>
inoremap w    <ESC>:w<CR>
nnoremap q	:q<CR>
nnoremap <Leader>h  <C-W>h
nnoremap <Leader>j  <C-W>j
nnoremap <Leader>k  <C-W>k
nnoremap <Leader>l  <C-W>l
nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprev<CR>
nnoremap <Leader>tl :tablast<CR>
nnoremap <Leader>tf :tabfirst<CR>
" }}} end of Maps

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
set cscopequickfix=s-,c-,d-,i-,t-,e-
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
	let csdb=findfile('cscope.out','.;')
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
	if filereadable(csdb . '/tags')
		set tags=''
		set tags+=csdb . '/tags'
	endif
	exec "cd " . cwd
endfunction
" }}} end of cscope

function! EditForGTEST()
	let delete_lines="SourcePrefix.h\\|CExampleTest.h\\|CPPUNIT_TEST\\|setUp\\|tearDown"
	%s/void \(.*\)::\(.*\)()/TEST(\1,\2)/g
	%s/CPPUNIT_ASSERT/EXPECT_TRUE/g
	exec "g/" . delete_lines . "/d"
	exec "%s/{\\_s*}//g"
	norm ggO#include "gtest/gtest.h
endfunction

" autocmd for different file types {{{
augroup FTAUGRP
	au!
	" python & Makefile files no expand tab "
	au FileType python,make     setlocal noet | setlocal ts=4
	au FileType c,cc,cpp        set cindent | set fdm=expr | setlocal foldexpr=getline(v:lnum)=~')'&&getline(v:lnum+1)=~'^{'?'>1':1
	au FileType vim 			set fdm=marker
augroup END
" }}}

" project specific settings {{{
if getcwd() =~ 'hione'
	set path=.,/home/warm/Doc/Code/hione/kernel/linux-4.1/include,/home/warm/Doc/Code/hione/kernel/linux-4.1/arch/arm64/include,
	cs add ~/Doc/cscope/kernel/cscope.out
	cs add ~/Doc/cscope/hisi_ap/cscope.out
endif

function! AddToPath()
	mkfile = getcwd() . '/Android.mk'

endfunction
" }}}

if filereadable('swap.vim')
	source ./swap.vim
endif
""let Tlist_Show_One_File=0                    " 只显示当前文件的tags
""let Tlist_Exit_OnlyWindow=1                  " 如果Taglist窗口是最后一个窗口则退出Vim
""let Tlist_Use_Right_Window=1                 " 在右侧窗口中显示
""let Tlist_File_Fold_Auto_Close=1             " 自动折叠
" vim:ts=4:sw=4:ft=vim:noet
