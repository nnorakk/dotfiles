-- install lazy if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- map the leader key
vim.g.mapleader = ' '  -- 'vim.g' sets global variables

require('lazy').setup({
    {'nvim-telescope/telescope.nvim', dependencies = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}} ,
    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/null-ls.nvim',
    {'glepnir/lspsaga.nvim',
        branch = "main",
        config = function()
            require('lspsaga').setup({})
    end} ,
    {'hrsh7th/nvim-cmp', dependencies = {
        {'hrsh7th/cmp-nvim-lsp'}, -- funciona aqui comentario?
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-vsnip'},
        {'hrsh7th/vim-vsnip'},
        {'hrsh7th/vim-vsnip-integ'},
        {'onsails/lspkind-nvim'}}
    } ,
    'windwp/nvim-autopairs',
    {'lewis6991/gitsigns.nvim', dependencies = {'nvim-lua/plenary.nvim'}} ,
    'lukas-reineke/indent-blankline.nvim',
    'rafamadriz/friendly-snippets',
    'mrjones2014/smart-splits.nvim',
    'voldikss/vim-floaterm',
    'echasnovski/mini.nvim',
    'joshdick/onedark.vim',
    'sainnhe/everforest',
    'williamboman/mason.nvim',
    'ellisonleao/gruvbox.nvim', -- tema portado lua
    {'itchyny/lightline.vim', dependencies = {'itchyny/vim-gitbranch'}} , -- statusline
    {'akinsho/bufferline.nvim', version = "v3.*", dependencies = 'nvim-tree/nvim-web-devicons'} , -- tabline
    'chentoast/marks.nvim',
    'christoomey/vim-tmux-navigator', -- interacao com tmux
    'tpope/vim-commentary', -- comentarios
    'tpope/vim-surround', --  manipular em ''"" em torno objetos mais complexos
    'tpope/vim-repeat', -- repete comandos
    'hashivim/vim-terraform', -- terraform
    'NvChad/nvim-colorizer.lua',
})
