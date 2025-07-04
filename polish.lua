-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- custom filetype
vim.filetype.add { extension = { mdx = "mdx" } }

-- :RgReplace <old> <new>
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
  vim.cmd(("argdo %%s/%s/%s/g | update"):format(vim.fn.escape(old, "/"), vim.fn.escape(new, "/")))
  vim.notify("Replacement complete!", vim.log.levels.INFO)
end, { nargs = "+", desc = "Find and replace text using ripgrep" })
