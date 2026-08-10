local M = {}

M.term_cwd = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) ~= "terminal" then
    return
  end

  local pid = vim.api.nvim_buf_get_var(bufnr, "terminal_job_pid")

  local handle = io.popen(string.format("pwdx %d", pid))
  if handle then
    local pwd = handle:read():gsub("^%d+:%s*", "")
    handle:close()
    return pwd
  end
end

return M
