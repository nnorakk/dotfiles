-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
-- Packer can manage itself
  use {'wbthomason/packer.nvim'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use {'neovim/nvim-lspconfig'}
  -- use {'kabouzeid/nvim-lspinstall'}
  use {'hrsh7th/nvim-cmp', requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/vim-vsnip'},
      {'hrsh7th/vim-vsnip-integ'},
      {'onsails/lspkind-nvim'}}
  }

  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  -- use {'sbdchd/neoformat'}
  -- use {'L3MON4D3/LuaSnip', requires = {'saadparwaiz1/cmp_luasnip'}}
  -- use {'sbdchd/neoformat'}
  use {'lukas-reineke/indent-blankline.nvim'}
  use {'rafamadriz/friendly-snippets'}

  -- -- Ja utilizados historicamente com o vim
  use {'morhetz/gruvbox'}
  use {'itchyny/lightline.vim', requires = {'itchyny/vim-gitbranch'}}
  -- use {'christoomey/vim-tmux-navigator'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'hashivim/vim-terraform'}
end)
