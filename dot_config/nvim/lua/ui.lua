local M = {}

-- Available splash animations with optional crop bounds {name, top, bottom}
-- Set top/bottom to nil for no cropping
M.splashes = {
    { name = "flyingdragon", top = 13, bottom = 36 },
    { name = "cactus", top = nil, bottom = nil },
    { name = "lighningtornado", top = nil, bottom = nil },
    { name = "lights", top = nil, bottom = nil },
    -- { name = "infinity", top = nil, bottom = nil },
}

M.load_splash = function(name, top, bottom)
    local milli = require("milli")
    local ok, splash = pcall(milli.load, { splash = name })
    if not ok then
        vim.notify("milli: splash '" .. name .. "' not found. Run :MilliInstall " .. name, vim.log.levels.WARN)
        return nil
    end
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

--- Pick a random splash and load it (with cropping if defined)
--- Returns nil if no splash could be loaded
M.random_splash = function()
    math.randomseed(os.time())
    local order = {}
    for i = 1, #M.splashes do
        order[i] = i
    end
    -- Shuffle so we try a random one first, then fall through others
    for i = #order, 2, -1 do
        local j = math.random(i)
        order[i], order[j] = order[j], order[i]
    end
    for _, idx in ipairs(order) do
        local choice = M.splashes[idx]
        local splash = M.load_splash(choice.name, choice.top, choice.bottom)
        if splash then
            return splash
        end
    end
    return nil
end

return M
