return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")

      local mason_lspconfig = require("mason-lspconfig")

      local mason_tool_installer = require("mason-tool-installer")

      mason.setup({})

      mason_lspconfig.setup({
        ensure_installed = {
          "tsserver",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "pyright",
          "bashls",
          "jsonls",
          "ltex",
          "marksman",
        },
        automatic_installation = true, -- not the same as ensure_installed
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier", -- prettier formatter
          "stylua", -- lua formatter
          "isort", -- python formatter
          "black", -- python formatter
          "pylint", -- python linter
          "eslint_d", -- js linter
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "L3MON4D3/LuaSnip", -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim", -- vs-code like pictograms
    },
    config = function()
      local cmp = require("cmp")

      local luasnip = require("luasnip")

      local lspkind = require("lspkind")

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
          pumheight = 50,
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          documentation = cmp.config.window.bordered({
            documentation = {
              border = "rounded",
              winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder",
            },
          }),
          completion = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<Enter>"] = cmp.mapping.confirm({ select = false }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "utilsnips" },
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local key = vim.keymap -- for conciseness

      local opts = { noremap = true, silent = true }
      local on_attach = function(client, bufnr)
        opts.buffer = bufnr

        opts.desc = "Show LSP references"
        key.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        key.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        key.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        key.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        key.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        key.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        key.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        key.set("n", "<C-d>", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        key.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        key.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        key.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        key.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        key.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      lspconfig["html"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure typescript server with plugin
      lspconfig["tsserver"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure css server
      lspconfig["cssls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure tailwindcss server
      lspconfig["tailwindcss"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      --
      -- configure python server
      lspconfig["pyright"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure bash server
      lspconfig["bashls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure json server
      lspconfig["jsonls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      -- configure latex server
      lspconfig["ltex"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure markdown server
      lspconfig["marksman"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure lua server (with special settings)
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          bash = { "prettier" },
          latex = { "prettier" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
