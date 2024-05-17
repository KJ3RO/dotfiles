return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    workspaces = {
      {
        name = "Obsidian",
        path = "~/Obsidian/",
      },
    },

    daily_notes = {
      folder = string.format("Journals/%s/%s/", os.date("%Y"), os.date("%m")),
      date_format = "%d",
      alias_format = "%Y-%m-%d",
      template = "Cards/Templates/Daily.md",
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    ---@param url string
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url }) -- Mac OS
    end,

    use_advanced_uri = true,

    templates = {
      folder = "Cards/Templates/",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {},
    },

    ui = {
      enable = true,
      update_debounce = 200,
      checkboxes = {
        [" "] = { char = "󰄰", hl_group = "ObsidianTodo" },
        ["x"] = { char = "󰄴", hl_group = "ObsidianDone" },
        ["!"] = { char = "", hl_group = "ObsidianUrgent" },
        ["?"] = { char = "", hl_group = "ObsidianDelayed" },
        ["-"] = { char = "󰩺", hl_group = "ObsidianTrash" },
      },
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "󰌹", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = "#DDD7B7" },
        ObsidianDone = { bold = true, fg = "#769DDD" },
        ObsidianUrgent = { bold = true, fg = "#D4313D" },
        ObsidianDelayed = { bold = true, fg = "#FF9C29" },
        ObsidianTrash = { bold = true, fg = "#6E9565" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },

    attachments = {
      img_folder = "Sources/Attachments", -- This is the default
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
  },
}
