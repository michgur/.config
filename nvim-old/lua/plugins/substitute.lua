return {
  "gbprod/substitute.nvim",
  config = function()
    local substitute = require("substitute")
    substitute.setup({})

    vim.keymap.set("n", "s", substitute.operator, { noremap = true, desc = "Substitute" })
    vim.keymap.set("n", "ss", substitute.line, { noremap = true, desc = "Substitute current line" })
    vim.keymap.set("n", "S", substitute.eol, { noremap = true, desc = "[S]ubstitute to end of line" })
    vim.keymap.set("x", "s", substitute.visual, { noremap = true, desc = "Substitute" })
  end,
}
