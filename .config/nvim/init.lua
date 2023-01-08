require 'plugins'
require('gitsigns').setup {}

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

-- https://github.com/Yggdroot/indentLine
vim.g.indentLine_enabled = 0

-- keymap
vim.api.nvim_set_keymap('n', '<C-t>', ':Fern . -drawer -toggle -width=30', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ff', ':Telescope find_files hidden=true theme=get_dropdown', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fs', ':Telescope live_grep hidden=true theme=get_dropdown', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fi', ':IndentLinesToggle', { noremap = true, silent = true })

-- https://github.com/neovim/nvim-lspconfig
local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end

-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

util = require "lspconfig/util"
nvim_lsp.gopls.setup {
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

-- lspkind
local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require 'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]
