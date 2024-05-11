vim.g.mapleader = " "

local key = vim.keymap

key.set("n", "<leader>e", vim.cmd.Ex)
key.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
key.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
key.set("n", "<leader>ll", ":VimtexCompile<CR>")
