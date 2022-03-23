return require('packer').startup(function()
-- Packer can manage itself
  use {'wbthomason/packer.nvim'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use {'neovim/nvim-lspconfig'}
  use {'hrsh7th/nvim-cmp', requires = {
      {'hrsh7th/cmp-nvim-lsp'}, -- funciona aqui comentario?
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/vim-vsnip'},
      {'hrsh7th/vim-vsnip-integ'},
      {'onsails/lspkind-nvim'}}
  }
  use {'windwp/nvim-autopairs'}
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'},}
  use {'lukas-reineke/indent-blankline.nvim'}
  use {'rafamadriz/friendly-snippets'}
  use {'mrjones2014/smart-splits.nvim'}
  -- -- Ja utilizados historicamente com o vim
  use {'morhetz/gruvbox'}
  use {'itchyny/lightline.vim', requires = {'itchyny/vim-gitbranch'}}
  use {'christoomey/vim-tmux-navigator'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'hashivim/vim-terraform'}
end)
