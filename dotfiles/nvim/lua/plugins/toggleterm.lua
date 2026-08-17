require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return math.min(vim.o.lines / 3.5, 30)
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.33
    end
  end,
}

local Terminal = require("toggleterm.terminal").Terminal
local on_open = function(_)
  vim.cmd "startinsert!"
  -- vim.keymap.set("n", "q", "<cmd>close<CR>", { noremap = true, silent = true, buffer = term.bufnr })
end
local on_close = function(_)
  vim.cmd "startinsert!"
end

vim.keymap.set("n", "<leader>tt", function()
  Terminal:new({ count = vim.v.count1, on_open = on_open, on_close = on_close }):toggle(nil, "float")
end, { desc = "Toggle terminal float" })
vim.keymap.set("n", "<leader>tv", function()
  Terminal:new({ count = vim.v.count1, on_open = on_open, on_close = on_close }):toggle(nil, "vertical")
end, { desc = "Toggle terminal vertical" })
vim.keymap.set("n", "<leader>tH", function()
  Terminal:new({ count = vim.v.count1, on_open = on_open, on_close = on_close }):toggle(nil, "horizontal")
end, { desc = "Toggle terminal horizontal" })
