-- ~/.config/nvim/lua/plugins.lua
return {
  -- カラースキーム
  {
    "tomasr/molokai",
    lazy = false, -- Neovim起動時に即座に読み込む
    priority = 1000,
  },

  -- GitHub Copilotプラグインの設定
  {
    "github/copilot.vim",
    config = function()
      require("config.copilot")
    end,
  },

  -- LSP関連
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  
  -- 補完プラグイン
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },
  
  -- ファイラー (defxの代替)
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("config.neo-tree")
    end,
  },
  
  -- ファジーファインダー (deniteの代替)
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("config.telescope")
    end,
  },
  
  -- コメントアウト
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  
  -- 構文のパース
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.nvim-treesitter")
    end,
  },

  
  -- インデントガイド
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      require("config.indent-blankline")
    end,
  },

  
  -- ホワイトスペース表示
  {
    "ntpeters/vim-better-whitespace",

    event = { "BufReadPre", "BufNewFile" },
  },
  
  -- その他の元の設定にあったプラグインは必要に応じて追加
}
