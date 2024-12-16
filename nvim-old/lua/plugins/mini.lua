return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.cursorword").setup({})
    local ai = require("mini.ai")
    ai.setup({
      custom_textobjects = {
        ["$"] = ai.gen_spec.pair("$", "$", { type = "greedy" }),
      },
      n_lines = 500,
    })
    -- require("mini.jump").setup({
    -- 	delay = {
    -- 		idle_stop = 0,
    -- 	},
    -- })
    require("mini.move").setup({})
    -- require("mini.pairs").setup({})
    local MiniSplitjoin = require("mini.splitjoin")
    MiniSplitjoin.setup({
      mappings = {
        toggle = "",
        split = "",
        join = "",
      },
    })

    vim.keymap.set("n", "<C-CR>s", MiniSplitjoin.toggle, { desc = "Toggle [s]plit-join" })
  end,
}
