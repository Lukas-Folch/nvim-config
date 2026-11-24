require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- escape
map("i", "jj", "<ESC>")
map("i", "kj", "<ESC>")
map("i", "jk", "<ESC>")
map("t", "<Esc>", [[<C-\><C-n>]])
map("t", "jj", [[<C-\><C-n>]])
map("t", "jk", [[<C-\><C-n>]])
map("t", "kj", [[<C-\><C-n>]])

-- Add empty lines before and after cursor line
map("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
map("n", "go", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>")

-- Set the working directory to the path of the current buffer.
map("n", "<leader>cdb", function()
  vim.cmd("cd " .. vim.fn.expand "%:p:h")
end, { desc = "Set working directory to path of buffer." })

-- Set the working directory up one directory
map("n", "<leader>cdu", function()
  vim.cmd "cd .."
end, { desc = "Set the working directory up one directory" })

-- Show Man page
map("n", "Km", function()
  local current_word = vim.fn.expand "<cword>"
  return ":tab Man " .. current_word .. "<CR>q<Tab>"
end, { desc = "Show the manual page of word under cursor", expr = true })
