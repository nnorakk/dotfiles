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
        "folke/which-key.nvim", -- gerencia atalhos
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
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
            { 'onsails/lspkind-nvim' } }
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { 'saadparwaiz1/cmp_luasnip' },
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
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
            { 'RubixDev/mason-update-all' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' } }
    },
    'ellisonleao/gruvbox.nvim',  -- tema portado lua
    {
        'itchyny/lightline.vim', -- statusline
        dependencies = { 'itchyny/vim-gitbranch' }
    },
    {
        'akinsho/bufferline.nvim', -- tabline
        version = "*",
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
