-- maps.lua

local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '  -- 'vim.g' sets global variables


options = { noremap = true, silent = true }
map('n', '<leader><esc>', ':nohlsearch<cr>', options)
map('n', '<leader>n', ':bnext<cr>', options)
map('n', '<leader>p', ':bprev<cr>', options)

-- atalhos rapidos economizam alguns movimentos
map('n', '<Leader>q', ':quit<CR>', options)
map('n', '<Leader>qa', ':quitall<CR>', options)
map('n', '<Leader>w', ':write<CR>', options)
map('n', '<Leader>x', ':xit<CR>', options)
map('n', '<Leader>so', ':source %<CR>', options)
map('n', '<Leader>cd', ':cd %:p:h<CR>', options)

-- insert mapping
map('i', 'jk', '<Esc>', {})

-- normal mapping
map('n', '<c-h>', '<c-w>h', options)
map('n', '<c-j>', '<c-w>j', options)
map('n', '<c-k>', '<c-w>k', options)
map('n', '<c-l>', '<c-w>l', options)

-- telescope plugin
map('n', '<Leader>ff', ':lua require("telescope.builtin").find_files({follow=true})<cr>', options)
map('n', '<Leader>fg', ':lua require("telescope.builtin").live_grep()<cr>', options)
map('n', '<Leader>fb', ':lua require("telescope.builtin").buffers()<cr>', options)
map('n', '<Leader>fh', ':lua require("telescope.builtin").help_tags()<cr>', options)
