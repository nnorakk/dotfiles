-- Map leader to space
vim.g.leader = ' ' -- leader map igual a espaco. Default e '\'

require('maps')
require('plugins')
require('settings')
require('completion')

-- pq nao seta em lua?
vim.cmd('colorscheme gruvbox')
vim.cmd('let g:diminactive=0')
