function! s:reselect()
    call feedkeys('gv')
endfunction

function! visual_movement#move_up() abort range
    if a:firstline - 1 > 0
        execute "'<,'>move '<-2" 
    endif
    call s:reselect()
endfunction

function! visual_movement#move_down() abort range
    if a:lastline + 1 <= line('$')
        execute "'<,'>move '>+1" 
    endif
    call s:reselect()
endfunction
