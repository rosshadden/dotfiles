local dap = require("dap")
local dapui = require("dapui")

--
-- SETUP
--

dap.adapters.godot = {
	type = "server",
	host = "127.0.0.1",
	port = 6006,
}

dap.configurations.gdscript = {{
	type = "godot",
	request = "launch",
	name = "Launch scene",
	project = "${workspaceFolder}",
	-- launch_scene = true,
}}

dapui.setup()

-- dap.listeners.before.attach.dapui_config = dapui.open
-- dap.listeners.before.launch.dapui_config = dapui.open
-- dap.listeners.before.event_terminated.dapui_config = dapui.close
-- dap.listeners.before.event_exited.dapui_config = dapui.close

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

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>D", "<plug><debug>", { silent = true })

vim.keymap.set("n", "<plug><debug>u", dapui.toggle, { desc = "debug: toggle UI" })

vim.keymap.set("n", "<plug><debug>c", dap.continue, { desc = "debug: start/continue" })
vim.keymap.set("n", "<plug><debug>C", function()
	dap.terminate()
	dapui.close()
end, { desc = "debug: terminate" })

vim.keymap.set("n", "<plug><debug>b", dap.toggle_breakpoint, { desc = "debug: toggle breakpoint" })
vim.keymap.set("n", "<plug><debug>B", function()
	dap.set_breakpoint(vim.fn.inuput("breakpoint condition: "))
end, { desc = "debug: set breakpoint" })

vim.keymap.set("n", "<plug><debug>j", dap.step_into, { desc = "debug: step into" })
vim.keymap.set("n", "<plug><debug>l", dap.step_over, { desc = "debug: step over" })
vim.keymap.set("n", "<plug><debug>k", dap.step_out, { desc = "debug: step out" })
