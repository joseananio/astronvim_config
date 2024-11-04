local utils = require "astronvim.utils"

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    -- Overrides
    ["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer - ovr" },
    ["<leader>o"] = {
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd.wincmd "p"
        else
          vim.cmd.Neotree "focus"
        end
      end,
      desc = "New Toggle Explorer Focus - ovr",
    },
    ["<leader>ts"] = { "<cmd>TermSelect<cr>", desc = "Select terminal - ovr" },
    ["<leader>ta"] = { "<cmd>ToggleTerm name=app direction=float<cr>", desc = "App terminal - ovr" },
    ["<CR>h"] = { "<cmd>C-U>TmuxNavigateLeft<cr>", desc = "Left" },
    ["<CR>j"] = { "<cmd>C-U>TmuxNavigateDown<cr>", desc = "down" },
    ["<CR>k"] = { "<cmd>C-U>TmuxNavigateUp<cr>", desc = "up" },
    ["<CR>l"] = { "<cmd>C-U>TmuxNavigateRight<cr>", desc = "right" },

    -- vuki656/package-info
    ["<leader>ks"] = {
      function() require("package-info").show() end,
      desc = "Show dependency versions",
      silent = true,
      noremap = true,
    },
    ["<leader>kh"] = {
      function() require("package-info").hide() end,
      desc = "Hide dependency versions",
      silent = true,
      noremap = true,
    },
    ["<leader>kt"] = {
      function() require("package-info").toggle() end,
      desc = "Toggle dependency versions",
      silent = true,
      noremap = true,
    },
    ["<leader>ka"] = {
      function() require("package-info").install() end,
      desc = "Add dependency",
      silent = true,
      noremap = true,
    },
    ["<leader>kc"] = {
      function() require("package-info").change_version() end,
      desc = "Change version on the line",
      silent = true,
      noremap = true,
    },
    ["<leader>ku"] = {
      function() require("package-info").update() end,
      desc = "Update dependency on the line",
      silent = true,
      noremap = true,
    },
    ["<leader>kd"] = {
      function() require("package-info").delete() end,
      desc = "Delete dependency on the line",
      silent = true,
      noremap = true,
    },
    ["<leader>fg"] = {
      function() require("telescope.builtin").live_grep { search_dirs = { "src" } } end,
      desc = "Search in src only",
      silent = true,
      noremap = true,
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = true,
  },
}
