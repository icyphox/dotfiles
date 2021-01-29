function! s:completed(winid, filename, action, ...) abort
    bdelete!
    call win_gotoid(a:winid)
    if filereadable(a:filename)
      let lines = readfile(a:filename)
      if !empty(lines)
        exe a:action . ' ' . lines[0]
      endif
      call delete(a:filename)
    endif
endfunction

function! FzyCommand(choice_command, vim_command)
    let file = tempname()
    let winid = win_getid()
    let cmd = split(&shell) + split(&shellcmdflag) + [a:choice_command . ' | fzy > ' . file]
    let F = function('s:completed', [winid, file, a:vim_command])
    botright 10 new
    if has('nvim')
        call termopen(cmd, {'on_exit': F})
    else
        call term_start(cmd, {'exit_cb': F, 'curwin': 1})
    endif
    startinsert
endfunction
