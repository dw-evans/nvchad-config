require "nvchad.mappings"

local map = vim.keymap.set

-- -- add yours here
-- local dap = require("dap")
-- map("n", "<leader>db", dap.toggle_breakpoint)
--
-- local dap_python = require("dap-python")
-- map("n", "<leader>dr", function()
--   dap_python.run_this()
-- end)
--

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")



-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
