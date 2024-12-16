return {
	"mfussenegger/nvim-dap",
	keys = function()
		local dap = require("dap")

		return {
			{ "gdd", dap.continue, desc = "Start / continue [d]ebugger" },
			{ "gdi", dap.step_into, desc = "Step [i]nto" },
			{ "gdo", dap.step_over, desc = "Step [o]ver" },
			{ "gdO", dap.step_out, desc = "Step [O]ut" },
			{ "gdb", dap.toggle_breakpoint, desc = "Toggle [b]reakpoint" },
			{
				"gdB",
				function()
					dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Set [B]reakpoint",
			},
		}
	end,
}
