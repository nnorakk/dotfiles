" seta relativenumber se o tipo for diferente de help
function! change_numbering#set_relativenumber() abort
    if &ft =~ 'help'
        return
    endif
    set relativenumber 
    set number
endfunction

" desabilita relativenumber se o tipo for diferente de help
function! change_numbering#unset_relativenumber() abort
    if &ft =~ 'help'
        return
    endif
    set norelativenumber 
    set number
endfunction
