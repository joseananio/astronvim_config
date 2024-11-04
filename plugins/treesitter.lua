return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      "lua",
      "typescript",
      "python",
      "go",
      "graphql",
      "tsx",
      "html",
      "markdown",
      "markdown_inline",
      "css",
    })
    -- read mdx files with the highlight for markdown files
    local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
    ft_to_parser.mdx = "markdown"
  end,
}
