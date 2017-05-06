function! MyHandler(channel, msg)
    echohl ErrorMsg
    echomsg a:msg
    echohl None
endfunction

function! TestArgs(...)
    "for item in split(a:args, '\\\@<!\s\+')
        "echo escape(item, ' \\')
    "endfor
    for item in a:000
        echo item
    endfor
endfunction

command! -nargs=+ TA call TestArgs(<f-args>)

let arr = [1,2,3,4,5]
echo index(arr, 3)
let arg='abc:def:ghi:l\:mn'

echo map(split(arg, '\\\@<!:', 1), 
    \   'substitute(v:val,"\\\\(.\\)",''\1'', "g")')
