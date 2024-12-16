return {
  "rasulomaroff/reactive.nvim",
  config = function()
    require("reactive").setup({
      load = {
        "catppuccin-macchiato-cursor",
        "catppuccin-macchiato-cursorline",
        "catppuccin-latte-cursor",
        "catppuccin-latte-cursorline",
      },
    })
  end,
}
