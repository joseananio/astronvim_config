-- Configure lsp servers
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              venvPath = "/Users/galactus/.local/share/virtualenvs/python-a6qCZaLG",
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
      },
    },
  },
}
