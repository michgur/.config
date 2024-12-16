---@param hex_str string hexadecimal value of a color
local hex_to_rgb = function(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local red, green, blue = string.match(hex_str, pat)
  return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

---@param fg_color string forecrust color
---@param bg_color string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
local function blend(fg_color, bg_color, alpha)
  local bg = hex_to_rgb(bg_color)
  local fg = hex_to_rgb(fg_color)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(hex, amount, bg)
  return blend(hex, bg or bg, math.abs(amount))
end

function preset()
  local palette = require("rosepine.palette")
  return {
    name = "my-preset",
    init = function()
      vim.opt.guicursor:append("a:ReactiveCursor")
    end,
    static = {
      winhl = {
        inactive = {
          CursorLine = { bg = darken(palette.overlay, 0.75, palette.base) },
          CursorLineNr = { bg = darken(palette.overlay, 0.75, palette.base) },
        },
      },
    },
    modes = {
      -- insert mode
      i = {
        hl = {
          ReactiveCursor = { bg = palette.teal },
        },
        winhl = {
          CursorLine = { bg = darken(palette.sky, 0.3, palette.base) },
          CursorLineNr = { bg = darken(palette.sky, 0.3, palette.base) },
        },
      },
      -- normal mode
      n = {
        winhl = {
          CursorLine = { bg = palette.surface0 },
          CursorLineNr = { bg = palette.surface0 },
        },
      },
      -- operator-pending mode
      no = {
        operators = {
          [{ "gu", "gU", "g~", "~" }] = {
            winhl = {
              CursorLine = { bg = palette.surface2 },
              CursorLineNr = { bg = palette.surface2 },
            },
          },
          -- delete operator
          d = {
            hl = {
              ReactiveCursor = { bg = palette.red },
            },
            winhl = {
              CursorLine = { bg = darken(palette.red, 0.4, palette.base) },
              CursorLineNr = { bg = darken(palette.red, 0.4, palette.base) },
            },
          },
          -- yank operator
          y = {
            hl = {
              ReactiveCursor = { bg = palette.peach },
            },
            winhl = {
              CursorLine = { bg = darken(palette.peach, 0.3, palette.base) },
              CursorLineNr = { bg = darken(palette.peach, 0.3, palette.base) },
            },
          },
          -- change operator
          c = {
            hl = {
              ReactiveCursor = { bg = palette.blue },
            },
            winhl = {
              CursorLine = { bg = darken(palette.blue, 0.4, palette.base) },
              CursorLineNr = { bg = darken(palette.blue, 0.4, palette.base) },
            },
          },
        },
      },
      R = {
        hl = {
          ReactiveCursor = { bg = palette.sapphire },
        },
        winhl = {
          CursorLine = { bg = darken(palette.sapphire, 0.4, palette.base) },
          CursorLineNr = { bg = darken(palette.sapphire, 0.4, palette.base) },
        },
      },
      -- visual mode
      [{ "v", "V", "\x16" }] = {
        hl = {
          ReactiveCursor = { bg = palette.mauve },
        },
        winhl = {
          Visual = { bg = darken(palette.mauve, 0.4, palette.base) },
        },
      -- select mode
      [{ "s", "S", "\x13" }] = {
        hl = {
          ReactiveCursor = { bg = palette.pink },
        },
        winhl = {
          Visual = { bg = darken(palette.pink, 0.4, palette.base) },
        },
      },
    },
  }
end
