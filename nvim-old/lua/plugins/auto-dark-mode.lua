local function reload_color_plugins(prev_palette, new_palette)
  vim.cmd.colorscheme("catppuccin-" .. new_palette)
  vim.cmd("Reactive disable catppuccin-" .. prev_palette .. "-cursor")
  vim.cmd("Reactive disable catppuccin-" .. prev_palette .. "-cursorline")
  vim.cmd("Reactive enable catppuccin-" .. new_palette .. "-cursor")
  vim.cmd("Reactive enable catppuccin-" .. new_palette .. "-cursorline")
  -- local preset = require("reactive-preset-setup").preset()
  -- require("reactive").add_preset(preset)
  vim.cmd("ReactiveToggle")
  vim.cmd("ReactiveToggle")
  require("statusline").setup()
  require("navic-setup").setup()
end

return {
  "f-person/auto-dark-mode.nvim",
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {})
      reload_color_plugins("latte", "macchiato")
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
      reload_color_plugins("macchiato", "latte")
    end,
  },
}
