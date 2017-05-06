
let maplocalleader ='\\'
nnoremap <LocalLeader>h :Denite help<CR>
nnoremap <LocalLeader>b :DeniteProjectDir buffer -path=`expand('%:p:h')`<CR>
nnoremap <LocalLeader>f :DeniteProjectDir file_rec -path=`expand('%:p:h')`<CR>
nnoremap <LocalLeader>l :Denite line<CR>

let maplocalleader ='  '
nnoremap <LocalLeader>h :Denite help<CR>
nnoremap <LocalLeader>b :DeniteProjectDir buffer -path=`expand('%:p:h')`<CR>
nnoremap <LocalLeader>f :DeniteProjectDir file_rec -path=`expand('%:p:h')`<CR>
nnoremap <LocalLeader>l :Denite line<CR>

" vim:ft=vim
