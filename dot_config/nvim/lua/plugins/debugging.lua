-- nvim-dap + dap-ui: Debug Adapter Protocol client with a graphical UI
-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/rcarriga/nvim-dap-ui
-- Keys: <leader>dt = toggle breakpoint, <leader>dc = continue,
--        <leader>dC = run to cursor, <leader>dT = terminate
return {
  "mfussenegger/nvim-dap",
  version = "^0.10.0",
  dependencies = {
    { "rcarriga/nvim-dap-ui", version = "^4.0.0" },
    { "nvim-neotest/nvim-nio", version = "^1.0.0" },
    { "leoluz/nvim-dap-go", commit = "b442115" },
    { "mfussenegger/nvim-dap-python", commit = "1808458" },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    require("dapui").setup()
    require("dap-go").setup()
    require("dap-python").setup("python")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint on current line" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Start or continue debugging" })
    vim.keymap.set("n", "<Leader>dC", dap.run_to_cursor, { desc = "Run to cursor position" })
    vim.keymap.set("n", "<Leader>dT", dap.terminate, { desc = "Terminate debug session" })
  end,
}
