-- NOTE: Autocommands

local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General", { clear = true })

autocmd("VimEnter", {
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- change to the directory
    if directory then
      vim.cmd.cd(data.file)
      vim.cmd "Telescope find_files"
      -- require("nvim-tree.api").tree.open()
    end
  end,
  group = general,
  desc = "Open Telescope when it's a Directory",
})

-- Hide folds and Disable statuscolumn in `nofile` buftype
autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "nofile" then
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.stc = "" -- not really important
    end
  end,
  group = general,
  desc = "Disable Fold & StatusColumn",
})

autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd "startinsert!"
  end,
  group = general,
  desc = "Terminal Options",
})

autocmd("BufReadPost", {
  callback = function()
    if fn.line "'\"" > 1 and fn.line "'\"" <= fn.line "$" then
      vim.cmd 'normal! g`"'
    end
  end,
  group = general,
  desc = "Go To The Last Cursor Position",
})

autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = general,
  desc = "Disable New Line Comment",
})

autocmd("FocusGained", {
  callback = function()
    vim.cmd "checktime"
  end,
  group = general,
  desc = "Update file when there are changes",
})

autocmd("VimResized", {
  callback = function()
    vim.cmd "wincmd ="
  end,
  group = general,
  desc = "Equalize Splits",
})

autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "log" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  group = general,
  desc = "Enable Wrap in these filetypes",
})

autocmd("FileType", {
    -- c/c++
  pattern = { "c", "cpp" },
  callback = function()
    vim.keymap.set("n", "<leader>lH", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "LSP | Switch Source/Header", silent = true })
  end,
  group = general,
  desc = "Keymap to switch between Source/Header",
})

local overseer = augroup("Overseer", { clear = true })

autocmd("FileType", {
  pattern = "OverseerList",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd "startinsert!"
  end,
  group = overseer,
  desc = "Enter Normal Mode In OverseerList",
})

-- For Godot
local godot = augroup("Godot", { clear = true })

autocmd("FileType", {
  pattern = { "gdscript" },
  callback = function()
    vim.g.godot = true
    local port = os.getenv "GDScript_Port" or "6005"
    local cmd = vim.lsp.rpc.connect("127.0.0.1", port)
    local pipe = "/tmp/godot.pipe"

    vim.lsp.start {
      name = "godot",
      cmd = cmd,
      root_dir = vim.fs.dirname(vim.fs.find({ "project.godot" }, { upward = true })[1]),
      on_attach = function(_, _)
        vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
      end,
    }
  end,
  group = godot,
  desc = "Start Godot LSP",
})
