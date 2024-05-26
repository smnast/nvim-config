-- NOTE: NvChad Related Mappings
local fn = vim.fn
local cwd = vim.fn.stdpath "config" .. "/"
local config_dir = { cwd }

-- Yank & delete all text
vim.keymap.set("n", "<leader>D", "<cmd>%d<cr>", { desc = "General | Delete All Text", silent = true })
vim.keymap.set("n", "<leader>y", "<cmd>%y+<cr>", { desc = "General | Yank All Text", silent = true })

-- Clear search highlighting
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>", { desc = "General | Clear search highlighting", silent = true })

-- Save & quit
vim.keymap.set('n', '<c-S>', ':w<CR>', { desc = "General | Save File", silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>qa!<cr>", { desc = "General | Quit", silent = true })
vim.keymap.set("n", "<leader>c", "<cmd>Bdelete!<cr>", { desc = "General | Close Buffer", silent = true })
vim.keymap.set("n", "<leader>w", function()
    require("nvchad.tabufline").close_buffer()
end, { desc = "General | Close Tabufline Buffer", silent = true })

-- Inverse tab
vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = "General | Inverse tab", silent = true })

-- Move between windows
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "General | Go to upper window", silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "General | Go to lower window", silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "General | Go to left window", silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "General | Go to right window", silent = true })

-- Add size
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "General | Add size at the top", silent = true })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "General | Add size at the bottom", silent = true })
vim.keymap.set( "n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "General | Add size at the left", silent = true })
vim.keymap.set( "n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "General | Add size at the right", silent = true })

-- Move between buffers
vim.keymap.set("n", "H", function()
  require("nvchad.tabufline").prev()
end, { desc = "General | Go to previous buffer", silent = true })
vim.keymap.set("n", "L", function()
  require("nvchad.tabufline").next()
end, { desc = "General | Go to next buffer", silent = true })

-- Move text in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "General | Move the selected text down", silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "General | Move the selected text up", silent = true })

-- Better Paste (Visual Mode)
vim.keymap.set("v", "p", '"_dP', { desc = "General | Better Paste", silent = true })

-- Indentation
vim.keymap.set("v", "<", "<gv", { desc = "General | Indent backward", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "General | Indent forward", silent = true })

-- Move the selected text (Visual Mode)
vim.keymap.set("v", "<C-J>", "<cmd>m '>+1<CR>gv=gv", { desc = "General | Move the selected text up", silent = true })
vim.keymap.set("v", "<C-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "General | Move the selected text down", silent = true })

-- Enter Insert Mode Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Enter Insert Mode", silent = true })

-- Word Search Increment
vim.keymap.set("c", "<Tab>", function()
  if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
    return "<CR>/<C-r>/"
  end
  return "<C-z>"
end, { desc = "General | Word Search Increment", expr = true })

-- Word Search Decrement
vim.keymap.set("c", "<S-Tab>", function()
  if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
    return "<CR>?<C-r>/"
  end
  return "<S-Tab>"
end, { desc = "General | Word Search Decrement", expr = true })

-- Find Config Files
vim.keymap.set("n", "<leader>nf", function()
  require("telescope.builtin").find_files {
    prompt_title = "Config Files",
    search_dirs = config_dir,
    cwd = cwd,
  }
end, { desc = "Neovim | Find Config Files", silent = true })

-- Grep Config Files
vim.keymap.set("n", "<leader>ng", function()
  require("telescope.builtin").live_grep {
    prompt_title = "Config Files",
    search_dirs = config_dir,
    cwd = cwd,
  }
end, { desc = "Neovim | Grep Config Files", silent = true })

-- Toggle Cheatsheet
vim.keymap.set("n", "<leader>nc", function()
  if vim.bo.filetype == "nvcheatsheet" then
    vim.cmd "Bdelete!"
  else
    vim.cmd "NvCheatsheet"
  end
end, { desc = "Neovim | Toggle Cheatsheet", silent = true })

-- Inspect
vim.keymap.set("n", "<leader>ni", function()
  if vim.fn.has "nvim-0.9.0" == 1 then
    vim.cmd "Inspect"
  else
    vim.notify("Inspect isn't available in this neovim version", vim.log.levels.WARN, { title = "Inspect" })
  end
end, { desc = "Neovim | Inspect", silent = true }) -- only available on neovim >= 0.9

-- Messages
vim.keymap.set("n", "<leader>nm", "<cmd>messages<cr>", { desc = "Neovim | Messages", silent = true })

-- Health
vim.keymap.set("n", "<leader>nh", "<cmd>checkhealth<cr>", { desc = "Neovim | Health", silent = true })

-- Version
vim.keymap.set("n", "<leader>nv", function()
  local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
  return vim.notify(version, vim.log.levels.INFO, { title = "Neovim Version" })
end, { desc = "Neovim | Version", silent = true })

-- Run Code
vim.keymap.set("n", "<leader>nr", function()
  RunCode()
end, { desc = "Neovim | Run Code", silent = true })

-- Append/insert should match indentation level
local function match_line(action)
    local line = vim.fn.getline('.')
    if #line == 0 or line:match('^%s+$') then
        return 'cc' -- empty line: change line
    else
        return action -- not empty: proceed as normal
    end
end
local function append()
    return match_line('a')
end

local function insert()
    return match_line('i')
end
vim.keymap.set('n', 'i', insert, { desc = "General | Improved Insert", silent = true, expr = true })
vim.keymap.set('n', 'a', append, { desc = "General | Improved Append", silent = true, expr = true })

