"finds all files in the current directory with TODO|FIXME

if exists("loaded_gotododo")
    finish
endif

let loaded_gotododo = 1

function! s:todo()
    pclose!
    below new
    let root_dir = s:findRoot()
    exe "%! egrep -HIrn 'TODO|FIXME' ".root_dir."* | awk 'BEGIN { FS = \":\" } ; { match($0,/(TODO|FIXME).*$/); gsub(/\t/,\" \"); print substr($0,RSTART,80)\"\t\"$1\":\"$2 };'"
    if exists(":Tabularize")
        exe '%Tabularize /\t/'
    endif
    setlocal ft=todo linespace=6 previewwindow nomodified nowrap
endfunction

command! Todo call s:todo()
au FileType todo noremap <buffer> <cr> f<tab>gF

function! s:findRoot()
  let root_stops = ['.git','.hg','.project']
  for rs in root_stops
    let root_dir = finddir(rs, '.;')
    if !empty(root_dir)
        return substitute(root_dir, "/".rs."$", "","")
    endif
  endfor
  " if no root return empty string
endfunction

