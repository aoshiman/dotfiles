function! s:Exec()
    exe "VimProcBang " . &ft . " %" 
:endfunction
command! Exec call <SID>Exec()
map <silent> <C-P> :call <SID>Exec()<CR>
