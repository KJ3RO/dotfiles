return {
  "nvim-neorg/neorg",
  dependencies = { "luarocks.nvim" },
  version = "*",
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
          config = {
            icon_preset = "varied",
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
      },
    })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
