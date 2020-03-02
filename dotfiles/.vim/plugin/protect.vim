set undodir=~/.vim/tmp/undo// 
if !isdirectory(expand(&undodir)) 
  call mkdir(expand(&undodir), 'p') " se o diretorio nao existir cria
endif
set undodir+=. " adiciona um local a mais para undo se o outro falhar
set undofile " seta undofile para persistir
set undolevels=1000 " seta o nivel para 1000

set backupdir=~/.vim/tmp/backup//
if !isdirectory(expand(&backupdir)) 
  call mkdir(expand(&backupdir), 'p') " se o diretorio nao existir cria
endif

set directory=~/.vim/tmp/swp//
if !isdirectory(expand(&directory)) 
  call mkdir(expand(&directory), 'p') " se o diretorio nao existir cria
endif
