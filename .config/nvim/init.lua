-- リーダーキーをスペースに設定（プラグイン読み込み前に設定）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- lazy.nvim のインストール（なければ自動でダウンロード）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグインの設定
require("lazy").setup({
  -- ファイルツリー
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- アイコン表示用
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        filters = {
          dotfiles = false, -- 隠しファイルも表示
        },
      })
    end,
  },

  -- 曖昧検索 (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },

  -- LSP関連
  -- mason: Language Serverのインストール管理
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- mason-lspconfig: masonとLSPの連携（サーバー自動インストール）
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",          -- Go
          "pyright",        -- Python
          "rust_analyzer",  -- Rust
          "ts_ls",          -- TypeScript/JavaScript
        },
        automatic_installation = true,
      })
    end,
  },

  -- Treesitter: 高精度シンタックスハイライト
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- パーサーを自動インストール
      local parsers = {
        "lua", "vim", "vimdoc", "javascript", "typescript",
        "python", "go", "rust", "json", "yaml", "html", "css", "markdown",
      }
      for _, parser in ipairs(parsers) do
        pcall(function()
          vim.treesitter.language.add(parser)
        end)
      end
    end,
  },

  -- 自動補完
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP補完
      "hrsh7th/cmp-buffer",       -- バッファ内の単語補完
      "hrsh7th/cmp-path",         -- ファイルパス補完
      "L3MON4D3/LuaSnip",         -- スニペットエンジン
      "saadparwaiz1/cmp_luasnip", -- スニペット補完
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- カラースキーム (Tokyo Night)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  -- ステータスライン
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
      })
    end,
  },

  -- Git変更表示
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- キーマップガイド
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- 括弧自動補完
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- コメント操作 (gc でコメントアウト)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- 自動フォーマット (conform.nvim)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer (conform)",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        rust = { "rustfmt" },
        go = { "gofmt", "goimports" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Markdown装飾表示
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({})
    end,
  },

})

-- LSP設定 (Neovim 0.11+ の新しいAPI)
-- LSPがバッファにアタッチしたときのキーマップ設定
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }

    -- コードジャンプ
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)           -- 定義へジャンプ
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)          -- 宣言へジャンプ
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)       -- 実装へジャンプ
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)           -- 参照一覧
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)      -- 型定義へジャンプ
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)                 -- ホバー情報表示
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)       -- リネーム
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- コードアクション
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)                                                         -- フォーマット
  end,
})

-- 各言語サーバーの設定と有効化
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "gopls", "pyright", "rust_analyzer", "ts_ls" }
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
  vim.lsp.enable(server)
end

-- キーマップ: スペース + e でファイルツリーを開閉
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- キーマップ: ウィンドウ間の移動
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "左のウィンドウへ" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "右のウィンドウへ" })

-- キーマップ: Telescope（曖昧検索）
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "ファイル名で検索" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "ファイル内容をgrep検索" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "開いているバッファ一覧" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "ヘルプを検索" })

-- 基本設定
vim.opt.number = true         -- 行番号を表示
vim.opt.relativenumber = true -- 相対行番号
vim.opt.mouse = "a"           -- マウス操作を有効化
vim.opt.termguicolors = true  -- True color対応
