---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- css
        "css-lsp",
        "cssmodules-language-server",
        "css-variables-language-server",
        "tailwindcss-language-server",

        -- js/ts
        "typescript-language-server",
        "eslint-lsp",

        -- formatters
        "prettierd",
        "stylua",
        -- "eslint_d", -- we use pretter

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
