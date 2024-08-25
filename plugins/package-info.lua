return {
  "vuki656/package-info.nvim",
  opts = {},
  config = function()
    require("package-info").setup {
      hide_up_to_date = true,
      hide_unstable_versions = true,
      autostart = true,
      colors = {
        up_to_date = "2",
        outdated = "1",
      },
    }
  end,
}
