" Background colors for active vs inactive windows
hi ActiveWindow guibg=#17252c
" hi ActiveWindow cterm=reverse ctermfg=208 ctermbg=235 gui=reverse guifg=#fe8019 guibg=#282828
" hi ActiveWindow ctermbg=grey10
" hi InactiveWindow ctermbg=237 guibg=#3c3836
" hi InactiveWindow ctermbg=237 " guibg=#3c3836
hi link InactiveWindow CursorLine
" highlight InactiveWindow ctermbg=grey20

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
    " hi ActiveWindow guibg=#17252c
    " hi InactiveWindow guibg=#0D1B22
    setlocal winhighlight=NormalNC:InactiveWindow
    " setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
" setlocal winhighlight=Normal:IncSearch,NormalNC:InactiveWindow
endfunction
