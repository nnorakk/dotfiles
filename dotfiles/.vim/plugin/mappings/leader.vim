nnoremap <silent> <Leader>r :call mappings#leader#cycle_numbering()<CR>
nnoremap <silent> <Leader>m :call mappings#leader#cycle_mouse()<CR>

" abre ou fecha fold
nnoremap <Leader><Leader> za

" equaliza tamanho das janelas
nnoremap <Leader>= <C-W>=
" converte de vertical para horizontal as janelas
nnoremap <Leader>- <c-w>t<c-w>K
" converte de horizontal para vertical as janelas
nnoremap <Leader>\ <c-w>t<c-w>H
nnoremap <Leader>\| <c-w>t<c-w>H

" atalhos rapidos economiza alguns movimentos
noremap <silent> <Leader>q :quit<CR>
noremap <silent> <Leader>qa :quitall<CR>
nnoremap <silent> <Leader>w :write<CR>
nnoremap <silent> <Leader>x :xit<CR>
nnoremap <silent> <Leader>so :source %<CR>

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
