return {
  -- Configure AstroNvim updates
  -- updater = {
  --   remote = "origin", -- remote to use
  --   channel = "stable", -- "stable" or "nightly"
  --   version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
  --   branch = "nightly", -- branch name (NIGHTLY ONLY)
  --   commit = nil, -- commit hash (NIGHTLY ONLY)
  --   pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
  --   skip_prompts = false, -- skip prompts about breaking changes
  --   show_changelog = true, -- show the changelog after performing an update
  --   auto_quit = false, -- automatically quit the current session after a successful update
  --   remotes = { -- easily add new remotes to track
  --     --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
  --     --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
  --     --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
  --   },
  -- },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  -- diagnostics = {
  --   virtual_text = true,
  --   underline = true,
  -- },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        -- allow_filetypes = { -- enable format on save for specified filetypes only
        --   -- "go",
        -- },
        -- ignore_filetypes = { -- disable format on save for specified filetypes
        --   -- "python",
        -- },
      },
      -- disabled = { -- disable formatting capabilities for the listed language servers
      --   -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
      --   -- "lua_ls",
      -- },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    -- servers = {
    --   -- "pyright"
    -- },
  },

  -- Configure require("lazy").setup() options
  -- lazy = {
  --   defaults = { lazy = true },
  --   performance = {
  --     rtp = {
  --       -- customize default disabled vim plugins
  --       disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
  --     },
  --   },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    vim.filetype.add {
      extension = {
        mdx = "mdx",
      },
      -- filename = {
      --   ["Foofile"] = "fooscript",
      -- },
      -- pattern = {
      --   ["~/%.config/foo/.*"] = "fooscript",
      -- },
    }

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MasonToolsStartingInstall',
      callback = function()
        vim.schedule(function()
          print 'mason-tool-installer is starting'
        end)
      end,
    })

    -- Define the RgReplace command
    -- Use as :RgReplace old_text new_text
    vim.api.nvim_create_user_command("RgReplace", function(args)
      local old = args.fargs[1] -- The text to find
      local new = args.fargs[2] -- The text to replace
      if not old or not new then
        vim.notify("Usage: RgReplace <old> <new>", vim.log.levels.ERROR)
        return
      end

      -- Use ripgrep to find files with the old text
      local rg_cmd = "rg --files-with-matches " .. vim.fn.shellescape(old)
      local result = vim.fn.systemlist(rg_cmd)

      if vim.v.shell_error ~= 0 then
        vim.notify("Ripgrep failed: " .. table.concat(result, "\n"), vim.log.levels.ERROR)
        return
      end

      -- Load the results into the argument list
      vim.cmd("args " .. table.concat(result, " "))

      -- Perform the find and replace on each file
      vim.cmd(string.format("argdo %%s/%s/%s/g | update", vim.fn.escape(old, "/"), vim.fn.escape(new, "/")))

      vim.notify("Replacement complete!", vim.log.levels.INFO)
    end, {
      nargs = "+",
      desc = "Find and replace text using ripgrep",
    })
  end,
}
