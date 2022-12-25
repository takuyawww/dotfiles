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

-- key mapping
vim.api.nvim_set_keymap('n', '<C-t>', ':Fern .', { noremap = true, silent = true })
