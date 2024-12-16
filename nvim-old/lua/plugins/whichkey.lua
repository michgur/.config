return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = function(ctx)
      return ctx.plugin and 0 or 50
    end,
  },
  config = function()
    -- local which_key = require("which-key")
  end,
}
