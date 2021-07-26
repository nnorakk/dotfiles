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

vim.opt.clipboard = 'unnamedplus' -- forca registros * e + em yank
vim.opt.foldmethod = 'indent' -- Usa folding atraves da identacao
vim.opt.foldlevel = 99  -- Abre sem folding
vim.opt.tabstop = 4 -- expande tabs em espacos
vim.opt.softtabstop = 4 -- expande tabs em espacos
vim.opt.shiftwidth = 4 -- expande tabs em espacos
vim.opt.expandtab = true -- expande tabs em espacos
vim.opt.number = true -- Seta line
vim.opt.relativenumber = true -- Seta relativenumber
vim.opt.cursorline = true -- Habilita highlight na linha atual
vim.opt.splitbelow = true -- " Preferencias ao splitar janelas
vim.opt.splitright = true -- " Preferencias ao splitar janelas
vim.opt.hidden = true -- Permite saltar para buffers nao salvos
vim.opt.showcmd = false -- Nao imprime comando na ultima linha
vim.opt.showmode = false -- Nao indica "INSERT","REPLACE","VISUAL" mode
vim.opt.termguicolors = true --
vim.opt.mouse = 'nv' -- habilita mouse modos normal e visual
vim.opt.completeopt = "menuone,noselect" --https://github.com/hrsh7th/nvim-compe
vim.opt.shortmess = vim.opt.shortmess + 'I' -- nao aparece tela inicial

vim.g.gruvbox_italic = 1 -- verificar pq aqui antes de tudo
vim.g.colors_name = 'gruvbox'

-- vim.cmd('highlight link CompeDocumentation NormalFloat')
-- vim.cmd('highlight Comment gui=italic')
