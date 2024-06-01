return {
  "nvim-neorg/neorg",
  dependencies = { "luarocks.nvim" },
  version = "*",
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.neorgcmd"] = {},
        ["core.autocommands"] = {
          config = {
            vimleavepre = true,
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              roam = "~/Roam/",
            },
            default_workspace = "roam",
          },
        },
        ["core.keybinds"] = {
          config = {
            default_keybinds = true,
          },
        },
        ["core.qol.toc"] = {
          config = {
            close_after_use = true,
          },
        },
        ["core.summary"] = {
          config = {
            strategy = "default",
          },
        },
        ["core.integrations.treesitter"] = {
          config = {
            install_parsers = true,
            configure_parsers = true,
          },
        },
        ["core.concealer"] = {
          config = {
            icon_preset = "varied",
            icons = {
              code_block = {
                conceal = true,
              },
            },
          },
        },
        --   ["core.latex.renderer"] = {
        --     config = {
        --       conceal = true,
        --       render_on_enter = true,
        --     },
        --   },
        --   ["core.integrations.image"] = {
        --     config = {},
        --   },
      },
    })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
