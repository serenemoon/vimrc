" configuration for YCM {{{
let g:ycm_confirm_extra_conf=0
" }}}
let maplocalleader = " "

let s:ycm_diag_bufnr = -1
function! s:ToggleYcmDiagsWin()
    if s:ycm_diag_bufnr == bufnr('%')
        let save_cursor = getcurpos()
        lclose
        call setpos('.', save_cursor)
        let s:ycm_diag_bufnr = -1
    else
        let s:ycm_diag_bufnr = bufnr('%')
        YcmDiags
    endif
endfunction

nnoremap <LocalLeader>dg :call <SID>ToggleYcmDiagsWin()<CR>
nnoremap <LocalLeader>df :YcmCompleter GoToDefinition<CR>
nnoremap <LocalLeader>dc :YcmCompleter GoToDeclaration<CR>


" vim:ft=vim
