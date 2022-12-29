require'packer'.startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- color scheme
  use "jacoborus/tender.vim"

  -- status line
  use 'itchyny/lightline.vim'

  -- file tree
  use "lambdalisue/fern.vim"
  use "lambdalisue/fern-git-status.vim"

  -- fzf
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- start screen
  use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }

  -- code support
  -- -- auto close
  use 'cohama/lexima.vim'
end)
