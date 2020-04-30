nnoremap <silent> <Leader>r :call mappings#leader#cycle_numbering()<CR>
nnoremap <silent> <Leader>m :call mappings#leader#cycle_mouse()<CR>

" fzf plugin atalhos
" Todos retirados de https://github.com/jesseleite/dotfiles/
" busca nos arquivos rastreados pelo git
nnoremap <Leader>f :GFiles<CR>
" busca nos arquivos do projeto
nnoremap <Leader>F :Files<CR>
" busca nos buffers
nnoremap <Leader>b :Buffers<CR>  " Buffer find
" busca no historico
nnoremap <Leader>h :History<CR>
" busca linha no buffer atual
nnoremap <Leader>l :BLines<CR>
" busca linha em todos os buffers 
nnoremap <Leader>L :Lines<CR>
" busca no help
nnoremap <Leader>H :Helptags!<CR>

" mapear :lnext e :lprevios do ALE linter
" nnoremap <Leader>ln :lnext<CR>
" nnoremap <Leader>lp :lprevious<CR>
