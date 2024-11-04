return {
  "vim-test/vim-test",
  cmd = {
    "TestNearest",
    "TestFile",
    "TestSuite",
    "TestLast",
    "TestVisit",
  },
  vim.keymap.set("n", "<leader>tcf", "<cmd>TestFile<cr>"),
  vim.keymap.set("n", "<leader>tcn", "<cmd><C-U>TestNearest<cr>"),
  vim.keymap.set("n", "<leader>tts", "<cmd>TestSuite<cr>"),
  vim.keymap.set("n", "<leader>ttl", "<cmd>TestLast<cr>"),
  vim.keymap.set("n", "<leader>ttg", "<cmd>TestVisit<cr>"),
  -- keys = {
  --   { "<leader>tty", "<cmd><C-U>TestNearest<cr>", desc = "sss" },
  -- },
}
