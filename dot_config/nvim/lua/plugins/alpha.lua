-- alpha-nvim: Customisable start screen with quick-access buttons
-- https://github.com/goolord/alpha-nvim
return {
    "goolord/alpha-nvim",
    commit = "4ba26e4",
    dependencies = {
        { "rubiin/fortune.nvim", version = "^1.0.0" },
        "amansingh-afk/milli.nvim",
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local ui = require("ui")

        -- Set header to first frame of milli animation (milli replaces it with
        -- subsequent frames once the alpha buffer opens)
        -- Crop the splash to remove blank padding rows (45 -> ~23 lines)
        local ok, splash = pcall(function()
            return ui.random_splash()
        end)
        if ok and splash.frames then
            dashboard.section.header.val = splash.frames[1]
        else
            dashboard.section.header.val = {
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                     ]],
                [[       ████ ██████           █████      ██                     ]],
                [[      ███████████             █████                             ]],
                [[      █████████ ███████████████████ ███   ███████████   ]],
                [[     █████████  ███    █████████████ █████ ██████████████   ]],
                [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
                [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
                [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
            }
        end

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":enew <BAR> startinsert <CR>"),
            dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
            dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("l", "󰁯  Last session", ":SessionRestore<CR>"),
            dashboard.button("m", "󰙅  Most frequent", ":Telescope frecency workspace=CWD<CR>"),
            dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h | :Neotree<CR>"),
            dashboard.button("q", "⏻  Quit NVIM", ":qa<CR>"),
        }

        local footer = function()
            local info = {}
            -- info[1] = "  Neovim loaded " .. vim.fn.strftime("%H:%M") .. " on " .. vim.fn.strftime("%d/%m/%Y") .. " '"
            info[1] = ""
            local fortune = require("fortune")
            fortune.setup({
                display_format = "mixed",
                content_types = "mixed",
            })
            local footer = vim.list_extend(info, fortune.get_fortune())
            return footer
        end

        dashboard.section.footer.val = footer()

        -- Send config to alpha
        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "alpha",
            callback = function()
                vim.opt_local.foldenable = false
            end,
        })
    end,
}
