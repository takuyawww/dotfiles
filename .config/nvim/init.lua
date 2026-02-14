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
          git_ignored = false, -- gitignoreされたファイルも表示
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
          "lua_ls",         -- Lua
          "kotlin_language_server", -- Kotlin
          "terraformls",    -- Terraform
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

  -- インデントガイド表示
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",  -- インデントの縦線文字
        },
        scope = {
          enabled = true,  -- 現在のスコープをハイライト
          show_start = true,
          show_end = false,
        },
      })
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

  -- 高速ジャンプ
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
    opts = {},
  },

  -- ターミナル管理
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical terminal" },
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "float",  -- float / horizontal / vertical
        float_opts = {
          border = "curved",
        },
      })
      -- ターミナルモードでのキーマップ
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)  -- Escでノーマルモードへ
        vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], opts)  -- Ctrl+qでノーマルモードへ
        vim.keymap.set("t", "<leader>tt", [[<C-\><C-n><cmd>ToggleTerm<cr>]], opts)  -- Space+ttで閉じる
        -- ターミナルから直接ウィンドウ移動
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
      end
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },

  -- エラー・警告一覧
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    opts = {},
  },

  -- Git diff表示
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
    },
    opts = {},
  },

  -- GitHub URLを開く
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gy", function() require("gitlinker").get_buf_range_url("n") end, desc = "Copy GitHub URL" },
      { "<leader>gy", function() require("gitlinker").get_buf_range_url("v") end, mode = "v", desc = "Copy GitHub URL (selection)" },
      { "<leader>gY", function() require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser }) end, desc = "Open in GitHub" },
      { "<leader>gY", function() require("gitlinker").get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser }) end, mode = "v", desc = "Open in GitHub (selection)" },
    },
    opts = {},
  },

  -- snacks.nvim (claudecode.nvimの依存関係)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
  },

  -- Claude Code integration
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      -- 送信後にClaudeにフォーカス
      focus_after_send = true,
      -- Diff設定
      diff_opts = {
        layout = "vertical",           -- 縦分割で差分表示
        open_in_new_tab = true,        -- 新タブで開く（見やすい）
        hide_terminal_in_new_tab = true,
      },
      -- ターミナル設定
      terminal = {
        split_side = "right",          -- 右側に配置
        split_width_percentage = 0.35, -- 少し広め
      },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "Send to Claude", mode = "v" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
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

-- 各言語サーバーの設定と有効化 (Neovim 0.11+ API)
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

-- 各サーバーの設定
vim.lsp.config("gopls", {
  cmd = { mason_bin .. "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("pyright", {
  cmd = { mason_bin .. "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", "requirements.txt" }
    local root = vim.fs.root(fname, markers)
    -- マーカーが見つからない場合はファイルのディレクトリを使用
    on_dir(root or vim.fn.fnamemodify(fname, ":h"))
  end,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})

vim.lsp.config("rust_analyzer", {
  cmd = { mason_bin .. "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
  cmd = { mason_bin .. "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "package.json", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  cmd = { mason_bin .. "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },  -- Neovim用にvimグローバルを認識
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("kotlin_language_server", {
  cmd = { mason_bin .. "kotlin-language-server" },
  filetypes = { "kotlin" },
  root_markers = { "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts", "pom.xml", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("terraformls", {
  cmd = { mason_bin .. "terraform-ls", "serve" },
  filetypes = { "terraform", "terraform-vars" },
  root_markers = { ".terraform", ".git" },
  capabilities = capabilities,
})

-- サーバーを有効化
vim.lsp.enable({ "gopls", "pyright", "rust_analyzer", "ts_ls", "lua_ls", "kotlin_language_server", "terraformls" })

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
vim.opt.clipboard = "unnamedplus"  -- システムクリップボードと連携

-- カーソル停止時に自動でホバー情報を表示
vim.opt.updatetime = 500  -- カーソル停止後の待機時間（ミリ秒）

local hover_group = vim.api.nvim_create_augroup("LspAutoHover", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  group = hover_group,
  callback = function()
    -- 既存のfloating windowがあれば何もしない
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        return
      end
    end
    -- LSPがアタッチされている場合のみホバー表示
    if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
      vim.lsp.buf.hover()
    end
  end
})
