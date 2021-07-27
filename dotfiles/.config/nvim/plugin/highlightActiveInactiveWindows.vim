" Cores para janelas inativas e ativas
hi InactiveWindow guibg=#333333
hi link ActiveWindow Normal

" seta opcoes ao ganhar o foco da janela
function! Win_Enter() abort
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

    " seta relativenumber se o tipo for diferente de help
    if &ft =~ 'help'
        return
    else
        set relativenumber
        set number
    endif
endfunction

" seta opcoes ao perder o foco da janela
function! Win_Leave() abort
    set winhighlight=Normal:InactiveWindow,NormalNC:InactiveWindow

    " seta relativenumber se o tipo for diferente de help
    if &ft =~ 'help'
        return
    else
        set norelativenumber
        set number
    endif
endfunction

" Monitora eventos de foco
augroup BgHighlight
    autocmd!
    autocmd WinEnter,FocusGained * call Win_Enter()
    autocmd WinLeave,BufLeave,FocusLost * call Win_Leave()
augroup END
