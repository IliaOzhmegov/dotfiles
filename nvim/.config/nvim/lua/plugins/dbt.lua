-- =============================================================================
-- DBT support — SQL linter, filetype configuration, and language setup
-- =============================================================================

return {
  -- Conform for code formatting with sqlfluff
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>mp",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        mode = "n",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
      },
      formatters = {
        sqlfluff = {
          command = "sqlfluff",
          args = { "format", "-" },
          stdin = true,
        },
      },
    },
  },

  -- Nvim-lint for dbt linting with sqlfluff
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        sql = { "sqlfluff" },
        ["sql.jinja"] = { "sqlfluff" },
      }

      lint.linters.sqlfluff = {
        cmd = "sqlfluff",
        args = { "lint", "-f", "json", "--dialect", "postgres" },
        stdin = true,
        stream = "stdout",
        ignore_exitcode = true,
        parser = require("lint.parser").from_json,
      }

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- TreeSitter support for Jinja2 (dbt templating)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "jinja2" })
      end
    end,
  },

  -- Filetype detection for dbt projects
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.dbt.sql", "models/**/*.sql", "macros/**/*.sql" },
        callback = function()
          vim.bo.filetype = "sql"
          -- Optional: Set dialect hint for sqlfluff (can be dbt)
          vim.b.sqlfluff_dialect = "postgres"  -- Change to your dbt dialect (postgres, snowflake, bigquery, etc.)
        end,
      })
    end,
  },
}
