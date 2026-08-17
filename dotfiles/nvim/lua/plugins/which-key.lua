local wk = require "which-key"

wk.setup {
  preset = "modern",
  delay = 280,
  spec = {
    { "<leader>w", desc = "Window actions" },
    { "<leader>f", desc = "Find" },
    { "<leader>t", desc = "Toggle options" },
    { "<leader>g", desc = "Git" },
    { "<leader><tab>", desc = "Tab pages" },
  },
}
