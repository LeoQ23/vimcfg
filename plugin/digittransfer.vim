fu! Thex(...)
    for nval in a:000
        echo printf("0x%x", eval(nval))
    endfor
endfu
command -nargs=* Toh call Thex(<f-args>)

fu! TDec(...)
    for nval in a:000
        echo printf("%d", eval(nval))
    endfor
endfu
command -nargs=* Tod call TDec(<f-args>)

nmap <leader>sh :Toh <C-R><C-R>=expand("<cword>")<CR><CR>
nmap <leader>sd :Tod <C-R><C-R>=expand("<cword>")<CR><CR>
