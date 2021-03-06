﻿let g:vimrc_dir=fnamemodify(resolve(expand('<sfile>')), ':p:h')
" source self made scripts
for plug in split(globpath(g:vimrc_dir . '/plugin', '*'))
    silent! exec 'source ' . plug
endfor

noremap <nowait> <ESC> <ESC>
colorscheme molokai
let mapleader=","
" configuration for vimmake {{{
let g:vimmake_mode = {'make':'async', 'run':'async'}
let g:vimmake_path = expand('~') . '/vimrc'

function! OpenQuickfixSilently()
	let save_winnr = winnr()
	exec "copen 15"
	exec save_winnr . " wincmd w"
endfunction

noremap  <F9>        :call OpenQuickfixSilently()<cr>:VimTool make<cr>
noremap  <F10>       :call OpenQuickfixSilently()<cr>:VimTool run<cr>
inoremap <F9>	<ESC>:call OpenQuickfixSilently()<cr>:VimTool make<cr>
inoremap <F10>	<ESC>:call OpenQuickfixSilently()<cr>:VimTool run<cr>
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
set shiftround
set ignorecase smartcase
filetype plugin indent on
syntax on
" }}} end of global conf
"set makeprg=mingw32-make.exe
" Maps: {{{
nnoremap <Leader>ww  :w<CR>
nnoremap <Leader>ee  :e ~/.vimrc<CR>
nnoremap <Leader>ss  :source ~/.vimrc<CR>
nnoremap <Leader>sl  :exec getline('.')<CR>
nnoremap <Leader>src :source %<CR>
nnoremap <Leader>qq  :q<CR>
nnoremap <Leader>qa  :qa<CR>

nnoremap <Leader>co  :bot copen 15<CR>
nnoremap <Leader>cc  :cclose<CR>
nnoremap n		:nohl<CR>
nnoremap <Leader>nh :nohl<CR>
nnoremap K			:let @/="<C-R><C-W>"<CR>
vnoremap K			y:let @/="<C-R>""<CR>

"resize window size
nnoremap <Leader>r= :resize +10<cr>
nnoremap <Leader>r- :resize -10<cr>
nnoremap <Leader>vr= :vertical resize +10<cr>
nnoremap <Leader>vr- :vertical resize -10<cr>

nnoremap h	<C-W><C-H>
nnoremap j	<C-W><C-J>
nnoremap k	<C-W><C-K>
nnoremap l	<C-W><C-L>
nnoremap e	A
inoremap e	A

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
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
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
	%s/CPPUNIT_ASSERT_EQUAL/EXPECT_EQ/g
	%s/CPPUNIT_ASSERT/EXPECT_TRUE/g
	exec "g/" . delete_lines . "/d"
	exec "%s/{\\_s*}//g"
	norm ggO#include "gtest/gtest.h
endfunction
command! EFG call EditForGTEST()

function! FileFormat()
	%s/\s\+$//
	retab
endfunction
command! FF call FileFormat()

" autocmd for different file types {{{
function! StartOfFold(lnum)
	let g:oneline_proto = getline(a:lnum) =~ '^\w.*)$'
				\ && getline(a:lnum + 1) =~ '^{'
	let g:twoline_proto = getline(a:lnum) =~ '^\w'
				\ && getline(a:lnum + 1) =~ ')$'
				\ && getline(a:lnum + 2) =~ '^{'
	return g:oneline_proto || g:twoline_proto
endfunction

augroup FTAUGRP
	au!
	" python & Makefile files no expand tab
	au FileType python,make     setlocal noet | setlocal ts=4
	au FileType c,cc,cpp        set cindent | setlocal fdm=expr | setlocal fde=StartOfFold(v:lnum)?'>1':1
	au FileType vim				set fdm=marker | nnoremap <buffer> <F10> :w<CR>:source %<CR>
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
function! PCLintInfo()
	set efm=%f:%l:\ $\ %t%m
endfunction
function! NewPcLintToQuickfix()
	%s:\\:/:g
	%s:^:/home/warm/Doc/Code/hione/:
endfunction
function! UseCurFileAsQFFile()
	call NewPcLintToQuickfix()
	call PCLintInfo()
	w
	cfile %
	copen
endfunction

function! PcLintToQuickfix()
	g!/\n^vendor\|^vendor/d
	%s/^\s\+//
	g!/^vendor/s/^/===/
	g/\[Reference[^]]*\]/s///
	g/^===/,/^===/-1 j
	sort
	%s///g
endfunction

let g:altwinnrs = []
function! PickUnpickWindow()
	let cur_winnr = winnr()
	let idx = index(g:altwinnrs, cur_winnr)
	if -1 == idx
		call add(g:altwinnrs, cur_winnr)
		echomsg bufname("%") . " picked."
	else
		unlet g:altwinnrs[idx]
		echomsg bufname("%") . " unpicked."
	endif
endfunction
nnoremap <leader>pc :call PickUnpickWindow()<CR>

function! AltNext()
	let cur_winnr = winnr()
	for nr in g:altwinnrs
		if nr != cur_winnr
			exec nr . " wincmd w"
			norm nzz
		endif
	endfor
	exec cur_winnr . " wincmd w"
endfunction
nnoremap <C-K>	:call AltNext()<CR>

function! IsUserBuf(bn)
	let s:ignbn = ['NERD_tree', '__Tagbar__']
	if empty(bn) | return v:false | en
	if empty(filter(map(s:ignbn, 'bn =~ v:val'), 'v:val == 1')) | return v:true
	el | return v:false | en
endf

function! UserBufWinDo(cmd) "{{{
	let winnr_save = winnr()
	let wininfo = getwininfo()
	for win in wininfo
		let bn = bufname(win['bufnr'])
		if IsUserBuf(bn)
			exec win['winnr'] . 'wincmd w'
			exec cmd
		en
	endfor
	exec winnr_save . 'wincmd w'
endfunction "}}}

""let Tlist_Show_One_File=0                    " 只显示当前文件的tags
""let Tlist_Exit_OnlyWindow=1                  " 如果Taglist窗口是最后一个窗口则退出Vim
""let Tlist_Use_Right_Window=1                 " 在右侧窗口中显示
""let Tlist_File_Fold_Auto_Close=1             " 自动折叠
" vim:ts=4:sw=4:ft=vim:noet
