return {
  { "folke/trouble.nvim", enabled = false },

  -- For curbing bad practtices

  {
    "antonk52/bad-practices.nvim",
    opts = {
      most_splits = 5, -- how many splits are considered a good practice(default: 3)
      most_tabs = 3, -- how many tabs are considered a good practice(default: 3)
      max_hjkl = 10, -- how many times you can spam hjkl keys in a row(default: 10)
    },
  },
  {
    "m4xshen/hardtime.nvim",
    event = "User AstroFile",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disabled_keys = {
        ["<Insert>"] = { "", "i" },
        ["<Home>"] = { "", "i" },
        ["<End>"] = { "", "i" },
        ["<PageUp>"] = { "", "i" },
        ["<PageDown>"] = { "", "i" },
      },
    },
    config = function(_, opts)
      require("hardtime").setup(opts)
      require("hardtime").enable()
    end,
  },

  -- use mason-tool-installer for automatically installing Mason packages

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- css
        "css-lsp",
        "cssmodules-language-server",
        "css-variables-language-server",
        "tailwindcss-language-server",

        -- js/ts
        "typescript-language-server",
        "eslint-lsp",

        -- formatters
        "prettierd",
        "stylua",
        -- "eslint_d", -- we use pretter

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },

  -- To surround contents with quotes

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- Managing npm packages

  {
    "vuki656/package-info.nvim",
    opts = {},
    config = function()
      require("package-info").setup {
        hide_up_to_date = true,
        hide_unstable_versions = true,
        autostart = true,
        colors = {
          up_to_date = "2",
          outdated = "1",
        },
      }
    end,
  },

  -- Managing comments marked as TODO. Can track them in telescope

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
    keys = {
      { "<leader>tdl", "<cmd>TodoTelescope<cr>", desc = "Open todos in telescope" },
    },
  },

  -- Breaks the buffer by word lentgh so we know when we go over

  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = 100,
      disabled_filetypes = { "help" },
    },
    config = function() require("smartcolumn").setup() end,
  },

  -- Uses ripgrep for search

  {
    "jremmen/vim-ripgrep",
    lazy = false, -- Load immediately
    config = function()
      -- Optional: Define custom keybindings or configurations here
      vim.g.rg_command = "rg --vimgrep" -- Use ripgrep with vimgrep format
    end,
  },

  -- Supposed to run code tests but doesnt work

  {
    "vim-test/vim-test",
    cmd = {
      "TestNearest",
      "TestFile",
      "TestSuite",
      "TestLast",
      "TestVisit",
    },
    vim.keymap.set("n", "<leader>tcf", "<cmd>TestFile<cr>"),
    vim.keymap.set("n", "<leader>tcn", "<cmd><C-U>TestNearest<cr>"),
    vim.keymap.set("n", "<leader>tts", "<cmd>TestSuite<cr>"),
    vim.keymap.set("n", "<leader>ttl", "<cmd>TestLast<cr>"),
    vim.keymap.set("n", "<leader>ttg", "<cmd>TestVisit<cr>"),
    -- keys = {
    --   { "<leader>tty", "<cmd><C-U>TestNearest<cr>", desc = "sss" },
    -- },
  },

  -- Allows easy navigation between nvim and tmux panels

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Syntax highlighting

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "lua",
        "typescript",
        "python",
        "go",
        "graphql",
        "tsx",
        "html",
        "markdown",
        "markdown_inline",
        "terraform",
        "css",
        "rust",
      })
      -- read mdx files with the highlight for markdown files
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<CR>h"] = { "<cmd>C-U>TmuxNavigateLeft<cr>", desc = "Tmux ←" },
          ["<CR>j"] = { "<cmd>C-U>TmuxNavigateDown<cr>", desc = "Tmux ↓" },
          ["<CR>k"] = { "<cmd>C-U>TmuxNavigateUp<cr>", desc = "Tmux ↑" },
          ["<CR>l"] = { "<cmd>C-U>TmuxNavigateRight<cr>", desc = "Tmux →" },

          ["<leader>b"] = { desc = "Buffers" },
          ["<leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },

          -- …the rest of your mappings…
        },
        t = {},
      },
    },
  },
}
