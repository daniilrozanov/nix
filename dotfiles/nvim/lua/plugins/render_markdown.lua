require("render-markdown").setup {
  completions = { lsp = { enabled = true } },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader>tm",
      "<cmd>RenderMarkdown toggle<cr>",
      { buffer = true, desc = "Toggle preview markdown" }
    )
  end,
})
