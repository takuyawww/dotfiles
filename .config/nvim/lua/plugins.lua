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
  use 'cohama/lexima.vim'
  use 'Yggdroot/indentLine'
end)
