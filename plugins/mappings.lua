-- Contains all our custom mappings written in plugin format
-- TODO: move some of these to their respective packages
return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          -- Tmux navigation
          ["<CR>h"] = { "<cmd>C-U>TmuxNavigateLeft<cr>", desc = "Tmux ←" },
          ["<CR>j"] = { "<cmd>C-U>TmuxNavigateDown<cr>", desc = "Tmux ↓" },
          ["<CR>k"] = { "<cmd>C-U>TmuxNavigateUp<cr>", desc = "Tmux ↑" },
          ["<CR>l"] = { "<cmd>C-U>TmuxNavigateRight<cr>", desc = "Tmux →" },

          -- Buffer picker & close
          ["<leader>b"] = { name = "Buffers" },
          ["<leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },

          -- Neo-tree explorer
          ["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
          ["<leader>o"] = {
            function()
              if vim.bo.filetype == "neo-tree" then
                vim.cmd.wincmd "p"
              else
                vim.cmd.Neotree "focus"
              end
            end,
            desc = "Toggle Explorer Focus",
          },

          -- Terminal management
          ["<leader>ts"] = { "<cmd>TermSelect<cr>", desc = "Select terminal" },
          ["<leader>ta"] = { "<cmd>ToggleTerm name=app direction=float<cr>", desc = "App terminal" },

          -- package-info.nvim
          ["<leader>ks"] = {
            function() require("package-info").show() end,
            desc = "Show dep versions",
            silent = true,
            noremap = true,
          },
          ["<leader>kh"] = {
            function() require("package-info").hide() end,
            desc = "Hide dep versions",
            silent = true,
            noremap = true,
          },
          ["<leader>kt"] = {
            function() require("package-info").toggle() end,
            desc = "Toggle dep versions",
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
            desc = "Change version",
            silent = true,
            noremap = true,
          },
          ["<leader>ku"] = {
            function() require("package-info").update() end,
            desc = "Update dependency",
            silent = true,
            noremap = true,
          },
          ["<leader>kd"] = {
            function() require("package-info").delete() end,
            desc = "Delete dependency",
            silent = true,
            noremap = true,
          },

          -- Telescope live_grep in `src/`
          ["<leader>fg"] = {
            function() require("telescope.builtin").live_grep { search_dirs = { "src" } } end,
            desc = "Search in src only",
            silent = true,
            noremap = true,
          },
        },
        t = {
          -- terminal-mode mappings (if any) go here
        },
      },
    },
  },
}
