---@type LazySpec
return {
  "AstroNvim/astrolsp", -- patch AstroLSP, not Telescope itself
  dependencies = { "nvim-telescope/telescope.nvim" }, -- be sure Telescope
  opts = function(_, opts) -- is on the rtp before these run
    local t = function(builtin) -- helper that defers the require
      return function() -- until the key is actually pressed
        require("telescope.builtin")[builtin]()
      end
    end

    opts.mappings.n.grr = { t "lsp_references", desc = "LSP references (Tel)" }
    opts.mappings.n.gri = { t "lsp_implementations", desc = "LSP impls (Tel)" }
    opts.mappings.n.grn = { t "lsp_definitions", desc = "LSP defs (Tel)" }
    opts.mappings.n.gra = { t "lsp_code_actions", desc = "Code actions (Tel)" }
  end,
}
