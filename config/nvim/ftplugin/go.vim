setlocal noexpandtab
setlocal autoindent
setlocal shiftwidth=4
setlocal smarttab
setlocal formatoptions=croql
setlocal tabstop=4

" stolen from https://go.googlesource.com/go/+/c4f5421/misc/vim/ftplugin/go/fmt.vim

if exists("b:did_ftplugin_go_fmt")
    finish
endif
if !exists("g:go_fmt_commands")
    let g:go_fmt_commands = 1
endif
if !exists("g:gofmt_command")
    if executable("goimports")
        let g:gofmt_command = "goimports"
    else
        let g:gofmt_command = "gofmt"
    endif
endif
if g:go_fmt_commands
    command! -buffer Fmt call s:GoFormat()
endif
function! s:GoFormat()
    let view = winsaveview()
    silent execute "%!" . g:gofmt_command
    if v:shell_error
        let errors = []
        for line in getline(1, line('$'))
            let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
            if !empty(tokens)
                call add(errors, {"filename": @%,
                                 \"lnum":     tokens[2],
                                 \"col":      tokens[3],
                                 \"text":     tokens[4]})
            endif
        endfor
        if empty(errors)
            % | " Couldn't detect gofmt error format, output errors
        endif
        undo
        if !empty(errors)
            call setloclist(0, errors, 'r')
        endif
        echohl Error | echomsg "Gofmt returned error" | echohl None
    endif
    call winrestview(view)
endfunction
let b:did_ftplugin_go_fmt = 1
" vim:ts=4:sw=4:et
