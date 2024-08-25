local M = {}

function M.format_comboconfig()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local formatted_lines = {}
  local indent_level = 0
  local indent_str = "  " -- Two spaces for indentation

  for _, line in ipairs(lines) do
    -- Trim leading and trailing whitespace
    line = line:gsub("^%s*(.-)%s*$", "%1")

    -- Check and remove trailing commas
    line = line:gsub(",%s*$", "")

    -- Check if the line is a key-value pair
    local key, value = line:match "^%s*([^%s]+)%s+(.+)$"
    if key and value then
      -- Add indentation
      local indent = string.rep(indent_str, indent_level)
      -- Format scalar value
      if tonumber(value) then
        table.insert(formatted_lines, indent .. key .. " " .. value)
      else
        table.insert(formatted_lines, indent .. key .. " '" .. value .. "'")
      end
    else
      -- Check if the line is an array or object
      if line:find "^%s*[%w_]+%s*%[" or line:find "^%s*[%w_]+%s*{" then
        -- Increase indentation
        indent_level = indent_level + 1
      elseif line:find "^%s*%]" or line:find "^%s*%}" then
        -- Decrease indentation
        indent_level = math.max(indent_level - 1, 0)
      end
      -- Add indentation
      local indent = string.rep(indent_str, indent_level)
      table.insert(formatted_lines, indent .. line)
    end
  end

  -- Update buffer with formatted lines
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)
end
-- print "Module loaded successfully"
return M
