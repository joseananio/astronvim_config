if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter
-- NOTE: See user.lua for Treesitter settings

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "make",
      "typescript",
      "javascript",
      "cmake",
      "css",
      "terraform",
      "python",
      "go",
      "graphql",
      "tsx",
      "html",
      "markdown",
      "markdown_inline",
      -- add more arguments for adding more treesitter parsers
    },
  },
  vim.treesitter.language.register("markdown", "mdx"),
}
