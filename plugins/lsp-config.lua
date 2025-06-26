-- Configure lsp servers
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              venvPath = "~/.local/share/virtualenvs/python-a6qCZaLG",
              analysis = {
                -- typeCheckingMode = "strict",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        vtsls = {
          filetypes = { "typescript", "typescriptreact", "typescript.tsx", "mdx", "typescript.mdx", "md" },
        },
        -- TypeScript via typescript-language-server
        tsserver = {
          -- ensure we call the external server you’ve installed:
          cmd = { "typescript-language-server", "--stdio" },
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "mdx",
            "typescript.mdx",
            "md",
          },
          -- you can add extra `settings` here if needed
        },
      },
    },
  },
}
