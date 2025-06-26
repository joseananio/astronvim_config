return {
  -- colorscheme
  colorscheme = "astrodark",

  -- LSP formatting
  lsp = {
    formatting = {
      format_on_save = {
        enabled = true,
      },
      timeout_ms = 1000,
    },
  },

  -- final customizations
  polish = function()
    -- file-type for .mdx
    vim.filetype.add { extension = { mdx = "mdx" } }

    -- Define the RgReplace command
    -- :RgReplace <old> <new> — find & replace via ripgrep
    vim.api.nvim_create_user_command("RgReplace", function(args)
      local old, new = args.fargs[1], args.fargs[2]
      if not (old and new) then
        vim.notify("Usage: RgReplace <old> <new>", vim.log.levels.ERROR)
        return
      end

      local result = vim.fn.systemlist("rg --files-with-matches " .. vim.fn.shellescape(old))
      if vim.v.shell_error ~= 0 then
        vim.notify("Ripgrep failed:\n" .. table.concat(result, "\n"), vim.log.levels.ERROR)
        return
      end

      vim.cmd("args " .. table.concat(result, " "))
      vim.cmd(string.format("argdo %%s/%s/%s/g | update", vim.fn.escape(old, "/"), vim.fn.escape(new, "/")))
      vim.notify("Replacement complete!", vim.log.levels.INFO)
    end, {
      nargs = "+",
      desc = "Find and replace text using ripgrep",
    })
  end,
}
