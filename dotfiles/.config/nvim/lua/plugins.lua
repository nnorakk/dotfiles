-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
-- Packer can manage itself
  use {'wbthomason/packer.nvim'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use {'neovim/nvim-lspconfig'}
  use {'kabouzeid/nvim-lspinstall'}
  use {'hrsh7th/nvim-cmp', requires = {{'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-buffer'}, {'onsails/lspkind-nvim'}}}
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use {'sbdchd/neoformat'}
  use {'lukas-reineke/indent-blankline.nvim'}
  -- Ja utilizados historicamente com o vim
  use {'morhetz/gruvbox'}
  use {'itchyny/lightline.vim', requires = {'itchyny/vim-gitbranch'}}
  use {'christoomey/vim-tmux-navigator'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'hashivim/vim-terraform'}
  -- use {'glepnir/lspsaga.nvim'}
end)
