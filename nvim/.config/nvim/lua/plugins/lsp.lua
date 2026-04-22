-- =============================================================================
-- LSP — Language Server Protocol (native vim.lsp.config API for Neovim 0.11+)
-- =============================================================================

return {
  -- Mason — installs LSP servers
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright",        -- Python
        "lua_ls",         -- Lua
        "sqlls",          -- SQL
        "yamlls",         -- YAML (dbt schema files)
      },
    },
  },

  -- Fidget — LSP progress indicator
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = { avoid = { "NvimTree" } },
      },
    },
  },

  -- Lazydev — Neovim lua API completions
  { "folke/lazydev.nvim", ft = "lua", opts = {} },

  -- LSP keymaps & server configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "folke/lazydev.nvim",
    },
    config = function()
      -- Capabilities for autocompletion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", require("telescope.builtin").lsp_references, "References")
          map("gI", vim.lsp.buf.implementation, "Go to implementation")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
        end,
      })

      -- Server configs using native vim.lsp.config (Neovim 0.11+)
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            codeLens = { enable = true },
            hint = { enable = true, semicolon = "Disable" },
          },
        },
      })

      vim.lsp.config("sqlls", {
        capabilities = capabilities,
      })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
          },
        },
      })

      -- Enable all configured servers
      vim.lsp.enable({ "pyright", "lua_ls", "sqlls", "yamlls" })
    end,
  },
}
