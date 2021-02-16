" comment and uncomment
function! Docomment(comment)
    let lnum = line('.')
    let comm_ident = "\/\/"
    let syntax_type = &syntax
    if syntax_type == "vim"
        let comm_ident = "\""
    elseif syntax_type == "cpp" || syntax_type == "c" || syntax_type == "java"
        let comm_ident = "\/\/"
    elseif syntax_type == "sh" || syntax_type == "rc"
        let comm_ident = "#"
    else
        return
    endif

    let numlines = v:count == 0 ? 1 : v:count
    if a:comment
        let curLine = lnum
        let commenColume = -1
        while curLine < lnum + numlines
            let strLine = getline(curLine)
            " uncomment first
            if strlen(strLine) != 0
                let strLine = substitute(strLine, '\(^\s*\)' . comm_ident . ' \{,1}', '\1', "")
                call setline(curLine, strLine)
            endif

            let charLine = split(strLine, '\zs')
            let lIdx = 0
            while lIdx < len(charLine)
                let c = charLine[lIdx]
                if c != ' ' && c != '\t' && c != '\r' && c != '\n'
                    if lIdx < commenColume || commenColume == -1
                        let commenColume = lIdx
                        break
                    endif
                endif
                let lIdx += 1
            endwhile
            let curLine += 1
        endwhile

        let curLine = lnum
        while curLine < lnum + numlines
            let strLine = getline(curLine)
            if strlen(strLine) != 0
                let charLine = split(strLine, '\zs')
                call insert(charLine, comm_ident . " ", commenColume)
                let changeLine = join(charLine, "")
                call setline(curLine, changeLine)
            endif
            let curLine += 1
        endwhile
    else
        let curLine = lnum
        while curLine < lnum + numlines
            let strLine = getline(curLine)
            if strlen(strLine) != 0
                let changeLine = substitute(strLine, '\(^\s*\)' . comm_ident . ' \{,1}', '\1', "")
                call setline(curLine, changeLine)
            endif
            let curLine += 1
        endwhile
    endif
endfunction

command! -range Ced call Docomment(1)
command! -range Unced call Docomment(0)

nmap <leader>cc :Ced<CR>
nmap <leader>cu :Unced<CR>
