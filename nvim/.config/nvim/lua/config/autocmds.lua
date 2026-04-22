-- =============================================================================
-- Autocommands
-- =============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", { clear = true }),
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- Set indentation for Python files
autocmd("FileType", {
  group = augroup("PythonIndent", { clear = true }),
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Set filetype for dbt SQL/Jinja files
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("DbtFileType", { clear = true }),
  pattern = { "*.sql" },
  callback = function()
    -- Detect dbt projects by looking for dbt_project.yml upward
    local dbt_root = vim.fs.find("dbt_project.yml", {
      upward = true,
      path = vim.fn.expand("%:p:h"),
    })
    if #dbt_root > 0 then
      vim.opt_local.filetype = "sql.jinja"
    end
  end,
})
