return {
  "SmiteshP/nvim-navic",
  dependencies = {
    "SmiteshP/nvim-navbuddy",
    "MunifTanjim/nui.nvim",
    "b0o/incline.nvim",
  },
  config = function()
    require("navic-setup").setup()
  end,
}
