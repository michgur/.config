return {
  setup = function()
    local colors = require("catppuccin.palettes").get_palette()
    local theme = {
      normal = {
        a = { bg = colors.sapphire, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.sapphire },
        c = { bg = colors.surface0, fg = colors.sapphire },
        -- c = { fg = colors.text },
      },
      insert = {
        a = { bg = colors.green, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.green },
        c = { bg = colors.surface0, fg = colors.green },
        -- c = { fg = colors.text },
      },
      visual = {
        a = { bg = colors.mauve, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.mauve },
        c = { bg = colors.surface0, fg = colors.mauve },
        -- c = { fg = colors.text },
      },
      replace = {
        a = { bg = colors.maroon, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.maroon },
        c = { bg = colors.surface0, fg = colors.maroon },
        -- c = { fg = colors.text },
      },
      command = {
        a = { bg = colors.peach, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface0, fg = colors.peach },
        c = { bg = colors.surface0, fg = colors.peach },
        -- c = { fg = colors.text },
      },
      inactive = {
        a = { bg = colors.base, fg = colors.text, gui = "bold" },
        b = { bg = colors.base, fg = colors.text },
        c = { bg = colors.base, fg = colors.text },
        -- c = { fg = colors.muted },
      },
    }

    require("lualine").setup({
      options = {
        theme = theme,
        section_separators = "",
        component_separators = "",
      },
      -- extensions = { "oil" },
      sections = {
        lualine_a = {
          {
            "mode",
            -- separator = { left = "", right = "" }
          },
        },
        lualine_b = {
          {
            "branch",
            -- separator = { left = "", right = "" }
          },
          {
            "diff",
            -- separator = { left = "", right = "" }
          },
          {
            "diagnostics",
            -- separator = { left = "", right = "" }
          },
          -- {
          --   "copilot",
          --   symbols = {
          --     status = {
          --       icons = {
          --         enabled = "",
          --         sleep = "", -- auto-trigger disabled
          --         disabled = "",
          --         warning = "",
          --         unknown = "",
          --       },
          --       -- hl = {
          --       --   enabled = "Added",
          --       --   sleep = "Added",
          --       --   disabled = "Ignore",
          --       --   warning = "Error",
          --       --   unknown = "Ignore",
          --       -- },
          --     },
          --   },
          --   show_colors = false,
          --   separator = { left = "", right = "" },
          -- },
        },
        lualine_c = {
          {
            function()
              if vim.api.nvim_buf_get_option(0, "filetype") == "oil" then
                return vim.fn.fnamemodify(require("oil").get_current_dir(), ":~")
              end
              local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
              if filename ~= "" then
                return filename
              end
              return "[No Name]"
            end,
            color = function()
              if vim.api.nvim_buf_get_option(0, "modified") then
                return { gui = "italic" }
              end
              return { gui = "bold" }
            end,
          },
        },
        lualine_x = {
          "encoding",
          "filetype",
        },
        lualine_y = {
          {
            "progress",
            -- separator = { left = "", right = "" }
          },
        },
        lualine_z = {
          {
            "location",
            -- separator = { left = "", right = "" }
          },
        },
      },
    })
  end,
}
