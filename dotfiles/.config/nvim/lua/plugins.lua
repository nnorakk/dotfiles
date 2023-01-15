return require('packer').startup({function()
-- Packer can manage itself
  use {'wbthomason/packer.nvim'}

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }

  use {'neovim/nvim-lspconfig'}
  use {'jose-elias-alvarez/null-ls.nvim'}

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

  use {'voldikss/vim-floaterm'}

  use {'echasnovski/mini.nvim'}

  use {'folke/tokyonight.nvim'}
  use {'joshdick/onedark.vim'}
  use {'lunarvim/darkplus.nvim'}
  use {'tanvirtin/monokai.nvim'}
  use {'williamboman/mason.nvim'}
  -- -- Ja utilizados historicamente com o vim
  use {'morhetz/gruvbox'} -- tema
  use {'itchyny/lightline.vim', requires = {'itchyny/vim-gitbranch'}} -- statusline
  use {'christoomey/vim-tmux-navigator'} -- interacao com tmux
  use {'tpope/vim-commentary'} -- comentarios
  use {'tpope/vim-surround'} --  manipular em ''"" em torno objetos mais complexos
  use {'tpope/vim-repeat'} -- repete comandos
  use {'hashivim/vim-terraform'} -- terraform
end,
config ={
  display = {
    open_fn = require('packer.util').float,
  }
}})
