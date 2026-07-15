local M = {}

M.load_splash = function(name, top, bottom)
  local splash = require("milli").load({ splash = name })
  if top == nil or bottom == nil then
    return splash
  end

  splash = vim.deepcopy(splash)
  for i, frame in ipairs(splash.frames) do
    splash.frames[i] = vim.list_slice(frame, top + 1, bottom)
  end
  if splash.colors then
    for i, cframe in ipairs(splash.colors) do
      splash.colors[i] = vim.list_slice(cframe, top + 1, bottom)
    end
  end
  splash.rows = bottom - top
  return splash
end

return M
