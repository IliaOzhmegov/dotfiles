-- =============================================================================
-- Copilot + CopilotChat (disabled due to <Esc> key conflict)
-- =============================================================================

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false },
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
          dismiss = false,
        },
      },
      nes = { enabled = false },
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
    end,
  },
}