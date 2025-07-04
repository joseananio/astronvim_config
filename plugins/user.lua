-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {
  { "folke/trouble.nvim", enabled = false },

  -- For curbing bad practtices

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
    ft = { "json" }, -- loads only for package.json / lockfiles
    dependencies = { "MunifTanjim/nui.nvim" },

    --------------------------------
    -- 1. plugin-level key-maps ----
    --------------------------------
    keys = {
      { "<leader>ks", function() require("package-info").show() end, desc = "Show dep versions" },
      { "<leader>kh", function() require("package-info").hide() end, desc = "Hide dep versions" },
      { "<leader>kt", function() require("package-info").toggle() end, desc = "Toggle dep versions" },
      { "<leader>ka", function() require("package-info").install() end, desc = "Add dependency" },
      { "<leader>kc", function() require("package-info").change_version() end, desc = "Change version" },
      { "<leader>ku", function() require("package-info").update() end, desc = "Update dependency" },
      { "<leader>kd", function() require("package-info").delete() end, desc = "Delete dependency" },
    },

    --------------------------------
    -- 2. plugin settings ---------
    --------------------------------
    opts = {
      hide_up_to_date = true,
      hide_unstable_versions = true,
      autostart = true,
      colors = {
        up_to_date = "2",
        outdated = "1",
      },
    },
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
  -- NOTE: we use this and not the treesitter.lua one

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
}
