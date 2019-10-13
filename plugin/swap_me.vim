let s:hsdict = {}
function! InstallHdrSrcMaps(hdr, src)   "{{{1
    for h in a:hdr
        let s:hsdict[h] = copy(a:src)
    endfor
    for s in a:src
        let s:hsdict[s] = copy(a:hdr)
    endfor
endfunction 

call InstallHdrSrcMaps(['h'], ['c', 'cc', 'cpp'])

function! FindDirContains(name) "{{{1
" FindDirContains: search upward for `name` directory:   
"   return '.': if `name` found in curr file dir. 
"   return '' : if not found
"   return found dir: if found upwards curr file dir
    let save_cwd = getcwd()
    exec 'cd ' . expand('%:p:h')

    let found = finddir(a:name, '.;') " try find dir first
    if empty(found)
        let found = findfile(a:name, '.;') " if dir not found, then try find file
    endif

    if found == a:name
        let found = '.' " `a:name` found in cur file , return '.'
    elseif empty(found)
        let found = '' " `a:name` not found, return ''
    else
        " return found without trailing `a:name`
        let found = strpart(found, 0, strridx(found, '/'))
    endif

    exec 'cd ' . save_cwd
    return found
endfunction

function! FindRepoDir()
    return FindDirContains('.repo')
endfunction

function! FindGitDir()	
    return FindDirContains('.git')
endfunction

function! SwapBetweenHdrSrc() "{{{1
    let root = expand('%:t:r')
    let ext  = expand('%:t:e')
    let gitdir = FindGitDir()
    let searchpath = './**,'
    if !empty(gitdir)
        let searchpath .= gitdir . '/**'
    endif
    let altfile_pat = root . (ext =~ 'h' ? '.c' : '.h')

    if bufnr(altfile_pat) != -1 
    " if altfile already opened, fg that buffer, then return
        exec 'buffer ' . bufnr(altfile_pat)
        return
    endif

    for ex in s:hsdict[ext]
        let altfile = findfile(root . '.' . ex, searchpath)
        "echo 'ext:' . ex . ' -> file:' . altfile
        if !empty(altfile)
        " if altfile found, edit, then return
            exec 'e ' . altfile
            return
        endif
    endfor
endfunction

" {{{1 key maps
nnoremap <Leader>aa 	:call SwapBetweenHdrSrc()<CR>

" vim: ft=vim
