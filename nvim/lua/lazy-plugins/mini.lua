return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.move").setup({})
    require("mini.ai").setup({
      n_lines = 500,
    })

    local splitjoin = require('mini.splitjoin')
    splitjoin.setup({})
    vim.keymap.set("n", "gs", splitjoin.toggle, { desc = "[s]plitjoin" })
  end,
}
