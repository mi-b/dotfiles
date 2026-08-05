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

--- Pick a random splash and load it (with cropping if defined)
M.random_splash = function()
	math.randomseed(os.time())
	local choice = M.splashes[math.random(#M.splashes)]
	return M.load_splash(choice.name, choice.top, choice.bottom)
end

return M
