-- Create a buffer local keymap to reformat, using the buffer local command.
local format = function()
  if vim.fn.executable("black") ~= 1 then
    print("Missing executable 'black'")
    return
  end
  if vim.fn.executable("isort") ~= 1 then
    print("Missing executable 'isort'")
    return
  end
  vim.api.nvim_command("write")
  vim.api.nvim_command("silent !black " .. bufname)
  vim.api.nvim_command("silent !isort " .. bufname)
  vim.api.nvim_command("edit")
end

local flake8 = function() 
  if vim.fn.executable("flake8") ~= 1 then
    print("Missing executable 'flake8'")
    return
  end
  vim.api.nvim_command("write")

  local bufpath = vim.api.nvim_buf_get_name(0)
  local output = vim.fn.system("flake8 " .. bufpath)
  local buf
  for _, _buf in ipairs(vim.api.nvim_list_bufs()) do
    local parts = vim.split(vim.api.nvim_buf_get_name(_buf), "/")
    if parts[#parts] == "__Flake8__" then
      buf = _buf
      break
    end
  end

  if not buf then
    buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(buf, "__Flake8__")
    vim.api.nvim_buf_set_option(buf, "filetype", "flake8")
    vim.api.nvim_buf_set_option(buf, "buftype", "quickfix")
    vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(buf, "swapfile", false)
    vim.api.nvim_buf_set_option(buf, "buflisted", false)
  end

  local win
  local tabpage = vim.api.nvim_get_current_tabpage()
  for _, _window in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
    if vim.api.nvim_win_get_buf(_window) == buf then
      win = _window
    end
  end

  if not win then
    vim.api.nvim_command("vsplit")
    win = vim.api.nvim_get_current_win()
  end

  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.split(output, "\n"))
end

return {
  format = format,
  flake8 = flake8,
}
