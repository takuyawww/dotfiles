require 'plugins'

-- basic
vim.opt.fileencoding = "utf-8"
vim.opt.cursorline = true
vim.opt.number = true

vim.cmd 'set autoindent'
vim.cmd 'set expandtab'
vim.cmd 'set smartindent'
vim.cmd 'set clipboard+=unnamedplus'
vim.cmd 'set noswapfile'
vim.cmd 'set shiftwidth=2'
vim.cmd 'set softtabstop=2'
vim.cmd 'set tabstop=2'
vim.cmd 'set termguicolors'
vim.cmd 'set laststatus=2'
vim.cmd 'set t_Co=256'
vim.cmd 'set pumblend=10'

vim.opt.syntax = enable
vim.cmd [[ colorscheme tender ]]

vim.g['fern#default_hidden'] = 1

-- key mapping
vim.api.nvim_set_keymap('n', '<C-t>', ':Fern . -drawer -toggle -width=30', { silent = true })
vim.api.nvim_set_keymap('n', 'ff', ':Telescope find_files hidden=true theme=get_dropdown', { silent = true })
vim.api.nvim_set_keymap('n', 'lg', ':Telescope live_grep hidden=true theme=get_dropdown', { silent = true })
