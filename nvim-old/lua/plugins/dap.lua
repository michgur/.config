return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle [b]reakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.toggle_breakpoint, { desc = "[c]ontinue" })
      vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>", { desc = "[c]ontinue" })
      vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>", { desc = "e[x]it" })
      vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>", { desc = "Step [o]ver" })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("~/Code/api/venv_html_extract/bin/python")
    end,
  },
}
