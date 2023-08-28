-- maps.lua

local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

-- map the leader key
map('n', '<Space>', '', {})

-- rapidamente remove highligth na busca recente
map('n', '<leader><esc>', ':nohlsearch<cr>', options)

-- movimentacao rapida entre buffers
map('n', '<leader>n', ':bnext<cr>', options)
map('n', '<leader>p', ':bprev<cr>', options)

-- atalhos rapidos economizam alguns movimentos
map('n', '<Leader>q', ':quit<CR>', options)
map('n', '<Leader>qa', ':quitall<CR>', options)
map('n', '<Leader>w', ':write<CR>', options)
map('n', '<Leader>x', ':xit<CR>', options)
map('n', '<Leader>so', ':source %<CR>', options)
map('n', '<Leader>cd', ':cd %:p:h<CR>', options)

-- Duplica a funcao abaixo da atual
-- https://github.com/omerxx/vim-notebook
map('n', '<Leader>yyb', 'V}y}p<CR>', options)

-- normal mapping
map('n', '<c-h>', '<c-w>h', options)
map('n', '<c-j>', '<c-w>j', options)
map('n', '<c-k>', '<c-w>k', options)
map('n', '<c-l>', '<c-w>l', options)

-- insert mapping
map('i', 'jk', '<Esc>', {})
map('i', '<C-u>', '<Esc>ui', {})
map('i', '<C-r>', '<Esc><C-r>i', {})

-- command mapping
map('c', '<c-e>', '<End>', {})
map('c', '<c-a>', '<Home>', {})

-- telescope plugin
map('n', '<Leader>ff', ':lua require("telescope.builtin").find_files({follow=true})<cr>', options)
map('n', '<Leader>fg', ':lua require("telescope.builtin").live_grep()<cr>', options)
map('n', '<Leader>fb', ':lua require("telescope.builtin").buffers()<cr>', options)
map('n', '<Leader>fh', ':lua require("telescope.builtin").help_tags()<cr>', options)

-- smart-splits plugin
vim.cmd [[nnoremap <silent> <M-j> :SmartResizeDown 3<cr>]]
vim.cmd [[nnoremap <silent> <M-k> :SmartResizeUp 3<cr>]]
vim.cmd [[nnoremap <silent> <M-h> :SmartResizeLeft 3<cr>]]
vim.cmd [[nnoremap <silent> <M-l> :SmartResizeRight 3<cr>]]

-- Floaterm plugin
map('n', '<F12>', ':FloatermToggle<cr>', options)
map('t', '<F12>', '<C-\\><C-n>:FloatermToggle<cr>', options)

-- vim-tmux-navigator
-- https://github.com/LazyVim/LazyVim/discussions/277
vim.cmd([[
 let g:tmux_navigator_no_mappings = 1
 let g:tmux_navigator_disable_when_zoomed = 0
  noremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
    noremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
    noremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
    noremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>
    noremap <silent> <c-\> :<C-U>TmuxNavigatePrevious<cr>
  ]])
