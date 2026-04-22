-- =============================================================================
-- UI plugins
-- =============================================================================

return {
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "gruvbox-material",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -- Which-key — shows pending keybinds
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "File explorer" },
    },
    opts = {
      filters = { dotfiles = false },
      view = { width = 35 },
    },
  },

  -- Detect tabstop/shiftwidth automatically
  { "tpope/vim-sleuth" },
}
