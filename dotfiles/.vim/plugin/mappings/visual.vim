" Move visual selection
" xnoremap J :m '>+1<CR>gv=gv
" xnoremap K :m '<-2<CR>gv=gv

xnoremap K :call visual_movement#move_up()<CR>
xnoremap J :call visual_movement#move_down()<CR>

xnoremap jk <Esc> 
xnoremap kj <Esc> 
