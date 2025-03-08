--Ustawienia podstawowe
vim.opt.number = true            -- Wyświetlanie numerów linii
vim.opt.relativenumber = true    -- Numerowanie względne
vim.opt.expandtab = true         -- Zamiana tabulacji na spacje
vim.opt.shiftwidth = 2           -- Domyślne wcięcie 2 spacje
vim.opt.tabstop = 2             -- Tab to 2 spacje
vim.opt.smartcase = true         -- Sprytne wyszukiwanie tekstu
vim.opt.smartindent = true       -- Sprytne wcięcia
vim.opt.wrap = false             -- Nie łamanie linii
vim.opt.hlsearch = true          -- Podświetlanie wyników wyszukiwania
vim.opt.incsearch = true         -- Wyszukiwanie w trakcie pisania
vim.opt.syntax = 'enable'        -- Włączanie składni
vim.opt.termguicolors = true     -- Używanie kolorów 24-bitowych
--
-- -- Ustawienia dla Pythona
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "setlocal shiftwidth=4 tabstop=4 expandtab"
})
--
-- Ustawienia dla markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal syntax=markdown"
})

-- Ustawienia dla plików CSV i JSON
vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv,json",
  command = "setlocal filetype=csv"
})

-- Kolorowanie tłem w ciemnym stylu
vim.cmd([[colorscheme slate]])

-- Umożliwienie kopiowania i wklejania z/do schowka systemowego
vim.opt.clipboard = "unnamedplus"  -- Używa systemowego schowka jako domyślnego


vim.api.nvim_set_keymap("i", "(", "()<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "{", "{}<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "[", "[]<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "\"", "\"\"<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "'", "''<Left>", { noremap = true })
