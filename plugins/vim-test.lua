return {
  "vim-test/vim-test",
  cmd = {
    "TestNearest",
    "TestFile",
    "TestSuite",
    "TestLast",
    "TestVisit",
  },
  vim.keymap.set("n", "<leader>tsn", ":TestNearest<CR>"),
  vim.keymap.set("n", "<leader>tsf", ":TestFile<CR>"),
  vim.keymap.set("n", "<leader>tss", "<cmd>TestSuite<CR>"),
  vim.keymap.set("n", "<leader>tsl", ":TestLast<CR>"),
  vim.keymap.set("n", "<leader>tsg", ":TestVisit<CR>"),
}
