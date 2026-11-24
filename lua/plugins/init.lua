return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason installs tools; mason-tool-installer auto-installs the list below on every start.
  -- This is the single place to list tools (do not also add ensure_installed to mason.nvim).
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",
        -- python
        "pyright",
        "black",
        "ruff",
        -- docker
        "hadolint",
        "dockerfile-language-server",
        -- web
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "eslint_d",
        "prettierd",
        -- C#
        "omnisharp",
        "csharpier",
        -- C / C++
        "clangd",
        "clang-format",
        -- rust
        "rust-analyzer",
        -- Java
        "jdtls",
        "java-debug-adapter",
        "java-test",
      },
      run_on_start = true,
      auto_update = false,
    },
    -- The plugin's own run_on_start hooks VimEnter, which has already fired by
    -- the time VeryLazy loads it, so trigger the install check manually.
    config = function(_, opts)
      local mti = require "mason-tool-installer"
      mti.setup(opts)
      mti.run_on_start()
    end,
  },

  -- oil file browser
  {
    "stevearc/oil.nvim",
    opts = {
      -- 1. Display metadata columns alongside icons
      columns = {
        "icon",
        "size",
        "mtime",
        "permissions",
      },
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,
      -- Show hidden files by default
      view_options = {
        show_hidden = true,
      },
      --winbar = "%!v:lua.get_oil_winbar()",
      win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
      },
      keymaps = {
        -- Easy quit shortcut with 'q'
        ["q"] = "actions.close",
        -- preview
        ["P"] = "actions.preview",
        -- Disable default "gs"
        ["gs"] = false,

        -- Remap the interactive sort menu to "gss"
        ["gss"] = {
          desc = "Change sort order",
          "actions.change_sort",
        },
        -- sort by mtime
        ["gsm"] = {
          desc = "Sort by modified time (descending)",
          callback = function()
            require("oil").set_sort {
              { "type", "asc" },
              { "mtime", "desc" },
            }
          end,
        },
        -- sort by ctime
        ["gsc"] = {
          desc = "Sort by changed time (meta data change) (descending)",
          callback = function()
            require("oil").set_sort {
              { "type", "asc" },
              { "ctime", "desc" },
            }
          end,
        },
      },
    },

    -- Lazy load on command or keymap
    cmd = "Oil",
    keys = {
      { "<leader>od", "<cmd>Oil ~/Downloads<CR>", desc = "Open Downloads in Oil" },
      { "<leader>os", "<cmd>Oil ~/Documents/sources<CR>", desc = "Open sources in Oil" },
      { "<leader>on", "<cmd>Oil ~/.config/nvim<CR>", desc = "Open Nvim Config in Oil" },
      { "<leader>oo", "<cmd>Oil <CR>", desc = "Open current directory in Oil" },
    },
  },

  -- Multi-cursor plugin
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      local api = require "nvim-tree.api"
      opts.on_attach = function(bufnr)
        local options = { buffer = bufnr, noremap = true, silent = true }
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "l", api.tree.change_root_to_node, options)
        vim.keymap.set("n", "h", api.tree.change_root_to_parent, options)
      end
      return opts
    end,
  },

  -- shader syntax highlighting
  {
    "beyondmarc/hlsl.vim",
    ft = { "hlsl", "compute", "cginc" },
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- Treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "c",
        "cpp",
        "python",
        "javascript",
        "typescript",
        "c_sharp",
        "java",
      },
    },
  },
  { "mfussenegger/nvim-jdtls", ft = "java" },
}
