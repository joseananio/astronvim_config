-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {

        -- telescope
        ["<leader>fg"] = {
          function() require("telescope.builtin").live_grep { search_dirs = { "src" } } end,
          desc = "Search in src only",
        },

        -- Neo-tree
        ["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
        ["<leader>o"] = {
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd "p"
            else
              vim.cmd.Neotree "focus"
            end
          end,
          desc = "Focus Explorer",
        },

        -- ToggleTerm
        ["<leader>ts"] = { "<cmd>TermSelect<cr>", desc = "Select terminal" },
        ["<leader>ta"] = { "<cmd>ToggleTerm name=app direction=float<cr>", desc = "App terminal" },
      },

      x = { -- visual mode

        -- vj and vk stop working the moment something remaps j or k in visual mode.
        -- AstroNvim v5 ships with rainbowhxz/accelerated-jk.nvim enabled by default, and that plugin replaces the native motions:
        -- override the plugin in visual mode
        j = { "j", desc = "down (native, keeps counts)" },
        k = { "k", desc = "up   (native, keeps counts)" },
        h = { "h", desc = "left   (native, keeps counts)" },
        l = { "l", desc = "right   (native, keeps counts)" },
      },
    },
  },
}
