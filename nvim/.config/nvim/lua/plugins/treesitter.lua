-- =============================================================================
-- Treesitter — syntax highlighting and text objects
-- =============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()

      -- Install parsers
      local ensure = {
        "python", "sql", "lua", "vim", "vimdoc", "yaml",
        "toml", "json", "markdown", "markdown_inline", "bash",
      }
      for _, lang in ipairs(ensure) do
        pcall(function() vim.treesitter.language.add(lang) end)
      end

      -- Enable treesitter highlighting and indentation
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- Textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup()

      -- Selection keymaps
      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end, { desc = "outer function" })
      vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end, { desc = "inner function" })
      vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end, { desc = "outer class" })
      vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end, { desc = "inner class" })

      -- Movement keymaps
      local move = require("nvim-treesitter-textobjects.move")
      local moves = {
        ["]f"] = { query = "@function.outer", desc = "Next function start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["[f"] = { query = "@function.outer", desc = "Prev function start" },
        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
      }
      for key, m in pairs(moves) do
        local forward = not key:match("^%[")
        local fn = forward and move.goto_next_start or move.goto_previous_start
        vim.keymap.set({ "n", "x", "o" }, key, function() fn(m.query, "textobjects") end, { desc = m.desc })
      end
    end,
  },
}
