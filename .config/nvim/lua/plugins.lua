require'packer'.startup(function()
  -- https://github.com/wbthomason/packer.nvim
  use 'wbthomason/packer.nvim'
  
  -- https://github.com/jacoborus/tender.vim
  use 'jacoborus/tender.vim'

  -- https://github.com/itchyny/lightline.vim
  use 'itchyny/lightline.vim'

  -- https://github.com/lambdalisue/fern.vim
  -- https://github.com/lambdalisue/fern-renderer-nerdfont.vim
  -- https://github.com/lambdalisue/nerdfont.vim
  -- https://github.com/lambdalisue/fern-git-status.vim
  use 'lambdalisue/fern.vim'
  use 'lambdalisue/fern-renderer-nerdfont.vim'
  use 'lambdalisue/nerdfont.vim'
  use 'lambdalisue/fern-git-status.vim'

  -- https://github.com/nvim-telescope/telescope.nvim
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- https://github.com/goolord/alpha-nvim
  use {
    'goolord/alpha-nvim',
    config = function ()
      require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }

  -- https://github.com/cohama/lexima.vim
  -- https://github.com/Yggdroot/indentLine
  -- https://github.com/lewis6991/gitsigns.nvim
  -- https://github.com/windwp/nvim-autopairs
  use 'cohama/lexima.vim'
  use 'Yggdroot/indentLine'
  use 'lewis6991/gitsigns.nvim'
  use {
 	  "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  -- https://github.com/neovim/nvim-lspconfig
  use 'neovim/nvim-lspconfig'

  -- https://github.com/onsails/lspkind.nvim
  -- https://github.com/L3MON4D3/LuaSnip
  -- https://github.com/hrsh7th/cmp-nvim-lsp
  -- https://github.com/hrsh7th/cmp-buffer
  -- https://github.com/hrsh7th/nvim-cmp
  use 'onsails/lspkind.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
end)
