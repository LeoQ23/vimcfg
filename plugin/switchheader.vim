"switch between c/c++ header and source file
function! SwitchSourceAndHeader()
    let curfile = expand('%:r')
    let curfile_ext = expand('%:e')
    if curfile != ""
        if curfile_ext == "c" || curfile_ext == "cpp"
            if filereadable("./" . curfile . ".h")
                execute "edit " . "./" . curfile . ".h"
            elseif filereadable("./" . curfile . ".hpp")
                execute "edit " . "./" . curfile . ".hpp"
            else
                echo "can't find header file " . curfile
            endif
        elseif curfile_ext == "h" || curfile_ext == "hpp"
            if filereadable(curfile . ".c")
                execute "edit " . "./" . curfile . ".c"
            elseif filereadable(curfile . ".cpp")
                execute "edit " . "./" . curfile . ".cpp"
            elseif filereadable(curfile . ".cxx")
                execute "edit " . "./" . curfile . ".cxx"
            else
                echo "can't find source file!"
            endif
        endif
    endif
endfunction

map <leader>o :call SwitchSourceAndHeader()<CR>
