local M = {}

M.is_windows = function()
  return vim.loop.os_uname().sysname == "Windows_NT"
end

M.notify_win_skip = function(module_name)
  vim.schedule(function()
    vim.notify("Not using " .. module_name .. " because ... you know ... Windows.", vim.log.levels.INFO)
  end)
end

M.skip_if_windows = function(module_name)
  if M.is_windows() then
    M.notify_win_skip(module_name)
    return true
  end
  return false
end

return M
