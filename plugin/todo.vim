"finds all files in the current directory with TODO|FIXME

if exists("loaded_gotododo")
    finish
endif

let loaded_gotododo = 1

function! <SID>todo()
    pclose!
    below new
    exe "%! egrep -HIrn 'TODO|FIXME' * | awk 'BEGIN { FS = \":\" } ; { match($0,/(TODO|FIXME).*$/); gsub(/\t/,\" \"); print substr($0,RSTART,80)\"\t\"$1\":\"$2 };'"
    if exists(":Tabularize")
        exe '%Tabularize /\t/'
    endif
    "setlocal ft=todo previewwindow ro nomodifiable nomodified nowrap
    "setlocal ft=todo linespace=6 previewwindow ro nomodified nowrap
    setlocal ft=todo linespace=6 previewwindow nomodified nowrap
endfu

command! Todo call s:todo()
au FileType todo noremap <buffer> <cr> f<tab>gF
