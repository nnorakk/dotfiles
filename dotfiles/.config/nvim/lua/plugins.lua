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
vim.g.mapleader = ' ' -- 'vim.g' sets global variables

require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim', -- fuzzy finder
        dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
    },
    'neovim/nvim-lspconfig',     -- LSP
    {
        'stevearc/conform.nvim', -- formatters
        opts = {},
    },
    'mfussenegger/nvim-lint',      -- linters
    {
        'nvim-tree/nvim-tree.lua', -- file tree explorer
        lazy = true,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        'glepnir/lspsaga.nvim',
        branch = "main",
        config = function()
            require('lspsaga').setup({})
        end
    },
    {
        'hrsh7th/nvim-cmp',             -- completion
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' }, -- funciona aqui comentario?
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/vim-vsnip' },
            { 'hrsh7th/vim-vsnip-integ' },
            { 'onsails/lspkind-nvim' } }
    },
    'windwp/nvim-autopairs',       -- automaticamente [],{},{}
    {
        'lewis6991/gitsigns.nvim', -- sinaliza modificacoes rastreadas pelo git
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    'lukas-reineke/indent-blankline.nvim', -- linhas de identacao de codigo
    'rafamadriz/friendly-snippets',        -- conjunto de snippets
    'mrjones2014/smart-splits.nvim',       -- manipula splits
    'voldikss/vim-floaterm',               -- terminal
    -- 'echasnovski/mini.nvim',
    {
        'williamboman/mason.nvim', -- instala lsp,linters,formatters
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' } }
    },
    'ellisonleao/gruvbox.nvim',  -- tema portado lua
    {
        'itchyny/lightline.vim', -- statusline
        dependencies = { 'itchyny/vim-gitbranch' }
    },
    {
        'akinsho/bufferline.nvim', -- tabline
        version = "v3.*",
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    'chentoast/marks.nvim',           -- bookmarks
    'christoomey/vim-tmux-navigator', -- interacao com tmux
    'tpope/vim-commentary',           -- comentarios
    'tpope/vim-surround',             -- manipular em ''"" em torno objetos mais complexos
    'tpope/vim-repeat',               -- repete comandos
    'hashivim/vim-terraform',         -- terraform
    'NvChad/nvim-colorizer.lua',      -- colore descricao de cores em hexadecimal
})
