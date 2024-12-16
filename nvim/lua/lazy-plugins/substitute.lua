return {
	"gbprod/substitute.nvim",
	keys = function()
		local substitute = require("substitute")
		substitute.setup({}) -- must be called

		return {
			{ "s", substitute.operator, desc = "[s]ubstitute" },
			{ "ss", substitute.line, desc = "[s]ubstitute current line" },
			{ "S", substitute.eol, desc = "[S]ubstitute to end of line" },
			{ "s", substitute.visual, mode = "x", desc = "[s]ubstitute" },
			{ "<Leader>S", '"+S', remap = true, desc = "[S]ubstitute to end of line" },
			{ "<Leader>s", '"+s', mode = { "n", "x" }, remap = true, desc = "[s]ubstitute" },
		}
	end,
}
