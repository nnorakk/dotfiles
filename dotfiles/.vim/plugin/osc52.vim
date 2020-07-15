function Osc52Yank()
    let buffer=system('base64', @0)
    let buffer=substitute(buffer, "\n", "", "")
    let buffer='\e]52;c;'.buffer.'\e\'
    silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape('/dev/tty')
endfunction

noremap <silent> <Leader>y y:<C-U>call Osc52Yank()<CR>

augroup Yank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
augroup END
