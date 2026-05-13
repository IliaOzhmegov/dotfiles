-- =============================================================================
-- Copilot + CopilotChat (disabled due to <Esc> key conflict)
-- =============================================================================

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      auth_provider_url = "https://ratepay.ghe.com/",

      panel = {
        enabled = false,
      },

      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        trigger_on_accept = false,
        keymap = {
          accept = "<M-l>",
          accept_word = "<M-w>",
          accept_line = "<M-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = false, -- keep the ESC workaround
        },
      },

      nes = {
        enabled = false,
      },

      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        ["."] = false,
      },

      should_attach = function(_, bufname)
        local name = vim.fn.fnamemodify(bufname, ":t"):lower()

        if name:match("^%.env") then
          return false
        end
        if name:match("secret") or name:match("credentials") then
          return false
        end

        return true
      end,
    },

    config = function(_, opts)
      require("copilot").setup(opts)

      local sug = require("copilot.suggestion")
      local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)

      vim.keymap.set("i", "<Esc>", function()
        if sug.is_visible() then
          sug.dismiss()
        end
        return esc
      end, { expr = true, desc = "Dismiss Copilot and exit insert" })

      vim.keymap.set("i", "<C-]>", function()
        if sug.is_visible() then
          sug.dismiss()
        end
      end, { desc = "Dismiss Copilot suggestion" })

      vim.keymap.set("n", "<leader>ca", "<cmd>Copilot auth signin<cr>", { desc = "Copilot sign in" })
      vim.keymap.set("n", "<leader>ci", "<cmd>Copilot auth info<cr>", { desc = "Copilot auth info" })
      vim.keymap.set("n", "<leader>ct", function()
        sug.toggle_auto_trigger()
      end, { desc = "Copilot toggle auto-trigger" })
    end,
  },
}