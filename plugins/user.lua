return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
    keys = {
      { "<leader>tdl", "<cmd>TodoTelescope<cr>", desc = "Open todos in telescope" },
    },
  },
  {
    "antonk52/bad-practices.nvim",
    opts = {
      most_splits = 3,
      most_tabs = 3,
      max_hjkl = 10,
    },
  },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = 100,
      disabled_filetypes = { "help" },
    },
  },
  -- Add vim-ripgrep plugin
  -- use Rg old_text to search for text and populate the quickfix list
  -- run :cfdo %s/old/new/gc | update to apply the substitution
  {
    "jremmen/vim-ripgrep",
    lazy = false, -- Load immediately
    config = function()
      -- Optional: Define custom keybindings or configurations here
      vim.g.rg_command = "rg --vimgrep" -- Use ripgrep with vimgrep format
    end,
  },
}
