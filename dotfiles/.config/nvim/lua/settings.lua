-- Opcoes default no neovim diferente do vim 8
--
-- vim.o.encoding = 'utf-8'  -- seta encoding
-- vim.o.background = 'dark' -- seta background
-- vim.o.hlsearch = true -- highlight termos buscados
-- vim.o.incsearch = true -- busca enquanto estiver digitando
-- vim.o.ignorecase = true -- ignore case em buscas /
-- vim.o.smartcase = true -- ignore case em buscas /
-- vim.o.fillchars="vert:│" -- Modifica o caracter separador vertical (U+2503, UTF-8: E2 94 83)
-- vim.o.backspace = 'indent,eol,start' -- comportamento backspace

vim.o.clipboard = 'unnamedplus' -- forca registros * e + em yank
vim.o.foldmethod = 'indent' -- Usa folding atraves da identacao
vim.o.foldlevel = 99  -- Abre sem folding
vim.o.tabstop = 4 -- expande tabs em espacos
vim.o.softtabstop = 4 -- expande tabs em espacos
vim.o.shiftwidth = 4 -- expande tabs em espacos
vim.o.expandtab = true -- expande tabs em espacos
vim.o.number = true -- Seta line
vim.o.relativenumber = true -- Seta relativenumber
vim.o.cursorline = true -- Habilita highlight na linha atual
vim.o.splitbelow = true -- " Preferencias ao splitar janelas
vim.o.splitright = true -- " Preferencias ao splitar janelas
vim.o.hidden = true -- Permite saltar para buffers nao salvos
vim.o.showcmd = false -- Nao imprime comando na ultima linha
vim.o.termguicolors = true -- 
vim.o.mouse = 'nv' -- habilita mouse modos normal e visual
vim.o.completeopt = "menuone,noselect" --https://github.com/hrsh7th/nvim-compe

vim.g.gruvbox_italic = 1 -- verificar pq aqui antes de tudo
vim.g.colors_name = 'gruvbox'

vim.cmd('highlight link CompeDocumentation NormalFloat')
vim.cmd('highlight Comment gui=italic')
