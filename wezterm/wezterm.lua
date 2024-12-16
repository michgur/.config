local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

config.term = "xterm-256color"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 17
config.adjust_window_size_when_changing_font_size = false
config.freetype_load_target = "Light"
config.line_height = 1.3
config.text_background_opacity = 1
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.window_background_opacity = 0.3
config.window_padding = {
  top = 0,
  bottom = 0,
  left = 0,
  right = 0,
}
config.window_close_confirmation = "NeverPrompt"
config.switch_to_last_active_tab_when_closing_tab = true
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.unix_domains = {
  {
    name = "unix",
  },
}
config.default_gui_startup_args = { "connect", "unix" }

config.leader = { key = "a", mods = "CMD" }
config.keys = {
  {
    key = "h",
    mods = "CTRL",
    action = wezterm.action.Hide,
  },
  {
    key = "v",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane({ confirm = false }),
  },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ShowLauncher,
  },
  {
    key = "d",
    mods = "LEADER",
    action = wezterm.action.ShowDebugOverlay,
  },
  {
    key = "r",
    mods = "LEADER",
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = "w",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      local workspaces = {}
      for _, w in ipairs(mux.get_workspace_names()) do
        table.insert(workspaces, {
          id = w,
          label = w,
        })
      end
      table.insert(workspaces, {
        id = "New Workspace",
        label = "New Workspace",
      })

      window:perform_action(
        act.InputSelector({
          action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
            if not id and not label then
              return
            else
              inner_window:perform_action(
                act.SwitchToWorkspace({
                  name = label,
                  spawn = {
                    label = label,
                    cwd = wezterm.home_dir,
                  },
                }),
                inner_pane
              )
            end
          end),
          title = "Choose Workspace",
          choices = workspaces,
          fuzzy = true,
          fuzzy_description = "Fuzzy find and/or make a workspace ",
        }),
        pane
      )
    end),
  },
}

wezterm.on("update-status", function(win, pane)
  if pane == nil or pane:get_current_working_dir() == nil then
    return
  end
  local p = pane:get_current_working_dir().file_path
  p = string.match(p, "[^/]+$")
  win:set_right_status(p .. " ")
  wezterm.mux.rename_workspace(win:active_workspace(), p)
end)

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CMD",
    action = wezterm.action.ActivateTab(i - 1),
  })
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CMD|OPT",
    action = wezterm.action.MoveTab(i - 1),
  })
end
local cmdToCtrl = { "Enter", "d", "u", "o", "i", "r", "z", "h", "j", "k", "l", "g", "t" }
for _, key in ipairs(cmdToCtrl) do
  table.insert(config.keys, {
    key = key,
    mods = "CMD",
    action = wezterm.action.SendKey({ key = key, mods = "CTRL" }),
  })
end

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    --   return "rose-pine-moon"
    -- else
    --   return "rose-pine-dawn"
    return "Catppuccin Macchiato"
  else
    return "Catppuccin Latte"
  end
end

function hex2rgb(hex, opacity)
  hex = hex:gsub("#", "")
  local t = {
    tonumber("0x" .. hex:sub(1, 2)),
    tonumber("0x" .. hex:sub(3, 4)),
    tonumber("0x" .. hex:sub(5, 6)),
    opacity,
  }
  return "rgba(" .. table.concat(t, ",") .. ")"
end

config.color_schemes = {}
function fix_colorscheme(name)
  local s = wezterm.color.get_builtin_schemes()[name]
  local opacity = config.window_background_opacity
  local bg = s.ansi[1] -- hex2rgb(s.background, opacity)

  s.cursor_bg = s.ansi[5]
  s.tab_bar = {
    background = bg,
    active_tab = {
      bg_color = s.ansi[7],
      fg_color = s.ansi[1],
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = s.ansi[1],
      fg_color = s.ansi[7],
    },
    inactive_tab_hover = {
      bg_color = s.ansi[6],
      fg_color = s.ansi[1],
    },
    new_tab = {
      bg_color = bg,
      fg_color = s.brights[8],
    },
    new_tab_hover = {
      bg_color = s.ansi[6],
      fg_color = s.ansi[1],
    },
  }
  config.color_schemes[name] = s
end

fix_colorscheme("Catppuccin Macchiato")
fix_colorscheme("Catppuccin Latte")
config.color_scheme = scheme_for_appearance(get_appearance())

-- wezterm.on("window-resized", function(window, pane)
--   local dims = window:get_dimensions()
--   wezterm.log_warn("window_resized " .. tostring(dims.pixel_width))
-- end)
--
return config
