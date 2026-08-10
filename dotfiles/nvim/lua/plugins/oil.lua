local utils = require "utils"

local oil = require "oil"

oil.setup {}

vim.keymap.set("n", "<leader>e", oil.open)

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TerminalKeymaps", { clear = true }),
  pattern = "*",
  callback = function(opts)
    local switch = function()
      vim.api.nvim_win_close(0, false)
      oil.open(utils.term_cwd(opts.buf))
    end
    vim.keymap.set("n", "o", switch, { buf = opts.buf })
    vim.keymap.set("t", "<C-o>", switch, { buf = opts.buf })
  end,
})
