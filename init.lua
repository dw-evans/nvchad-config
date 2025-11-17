vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.opt.number = true
vim.opt.relativenumber = true

local map = vim.keymap.set

map({ "n", "v", "i" }, "<Up>", "<Nop>")
map({ "n", "v", "i" }, "<Down>", "<Nop>")
map({ "n", "v", "i" }, "<Left>", "<Nop>")
map({ "n", "v", "i" }, "<Right>", "<Nop>")
-- map({"n", "v", "i"}, "<C-s>", "<Nop>")

-- map({"i"}, "jj", "<Esc>")
map({ "i" }, "jk", "<Esc>")

-- prime dhh video - teej suggested using control+y for accepting autocomplete.

-- map("", )

vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")

map("n", "<leader><F2>", function()
  vim.lsp.buf.rename()
end)

-- local cmp = require "cmp"
--
-- cmp.setup {
--   mapping = {
--     ["<CR>"] = cmp.mapping(function(fallback)
--       if cmp.visible() and cmp.get_selected_entry() then
--         cmp.confirm { select = false }
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--   },
-- }

-- local cmp = require("cmp")
-- cmp.setup({
--   mapping = {
--     ["<CR>"] = cmp.mapping(function(fallback)
--       -- Only insert a newline; never confirm a suggestion
--       fallback()
--     end, { "i", "s" }),
--   },
-- })



vim.keymap.set("n", "<C-v>", "<C-v>", { noremap = true })
