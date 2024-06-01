vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local key = vim.keymap

-- key.set("n", "<leader>e", vim.cmd.Ex)
key.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
key.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
key.set("n", "<leader>r", ":reg<CR>")

key.set("n", "<C-s>", ":MarkdownPreviewToggle<CR>")
key.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
key.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
key.set("n", "<leader>tt", ":TodoTelescope<CR>")

key.set("n", "<leader>e", ":Oil<CR>")
