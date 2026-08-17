local opt = vim.opt_local

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    opt.number = false
    opt.relativenumber = false
    opt.scrolloff = 0
    vim.keymap.set("n", "gf", function()
      local file = vim.fn.expand "<cfile>"
      if #file == 0 or not file then
        return
      end
      vim.cmd "hide"
      vim.cmd("edit " .. vim.fn.fnameescape(file))
    end, { desc = "Open file under cursor" })
  end,
})

-- Easily hit escape in terminal mode.
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("t", "<m-q>", "<c-\\><c-n><cmd>quit<cr>")
