return {
  {
    "tpope/vim-dadbod",
    lazy = true,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_hide_schemas = { "^dev_bijil", "^dev_ben" }
      vim.g.db_adapter_bigquery_region = "region-us"
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    ft = { "sql", "mysql", "plsql" },
  },
}
