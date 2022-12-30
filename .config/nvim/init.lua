require 'plugins'

vim.opt.fileencoding = 'utf-8'
vim.opt.cursorline = true
vim.opt.number = true

vim.cmd [[
  set autoindent
  set expandtab
  set smartindent
  set clipboard+=unnamedplus
  set noswapfile
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
  set termguicolors
  set pumblend=10
]]

-- https://github.com/jacoborus/tender.vim
vim.opt.syntax = enable
vim.cmd [[ colorscheme tender ]]

-- https://github.com/itchyny/lightline.vim
vim.g.lightline = { colorscheme = 'wombat' }

-- https://github.com/lambdalisue/fern.vim
-- https://github.com/lambdalisue/fern-renderer-nerdfont.vim
-- https://github.com/lambdalisue/nerdfont.vim
vim.g['fern#default_hidden'] = 1
vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern#renderer#nerdfont#indent_markers'] = 1

vim.g.indentLine_enabled = 0

vim.api.nvim_set_keymap('n', '<C-t>', ':Fern . -drawer -toggle -width=30', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ff', ':Telescope find_files hidden=true theme=get_dropdown', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fs', ':Telescope live_grep hidden=true theme=get_dropdown', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fi', ':IndentLinesToggle', { noremap = true, silent = true })
