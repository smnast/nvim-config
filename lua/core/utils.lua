-- NOTE: Utilities and Commands

local command = vim.api.nvim_create_user_command

command("Format", function(args)
  local status_ok, conform = pcall(require, "conform")
  if not status_ok then
    return vim.notify "conform.nvim isn't installed!!!"
  end

  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  conform.format { async = true, lsp_fallback = true, range = range }
  vim.notify("Format Done", vim.log.levels.INFO, { title = "Format" })
end, { nargs = "*", desc = "Code Format", range = true })

command("LuaSnipEdit", function()
  require("luasnip.loaders").edit_snippet_files()
end, { nargs = "*", desc = "Edit the available snippets in the filetype" })

command("RemoveEmptyLines", function()
  vim.cmd ":g/^$/d"
  -- :v/./d
  --
  -- :g/^\s*$/d
  -- :v/\S/d
end, { nargs = "*", desc = "Remove all empty lines" })
command("RemoveTrailingSpaces", function()
  vim.cmd ":%s/s+$//e"
end, { nargs = "*", desc = "Remove all trailing spaces" })

command('HeaderGuard', function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    local file_name = string.upper(string.gsub(vim.fn.expand('%:t'), '%.', '_'))
    local project_name = string.upper(vim.fn.fnamemodify(vim.fn.getcwd(), ':t'))
    local def = project_name .. '_' .. file_name

    vim.api.nvim_command('normal ggO')
    vim.api.nvim_command('normal i' .. '#ifndef ' .. def)
    vim.api.nvim_command('normal o')
    vim.api.nvim_command('normal i' .. '#define ' .. def)
    vim.api.nvim_command('normal o')
    vim.api.nvim_command('normal Go')
    vim.api.nvim_command('normal i' .. '#endif //' .. def)
    vim.api.nvim_command('normal O')
    vim.api.nvim_command('')

    cursor_pos = {cursor_pos[1] + 3, cursor_pos[2]}
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end, { nargs = "*", desc = "Generate Header Guard" })

function ClickGit()
  local status_ok, _ = pcall(require, "toggleterm")
  if not status_ok then
    return vim.notify "toggleterm.nvim isn't installed!!!"
  end

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
  lazygit:toggle()
end

function ClickSplit()
  vim.cmd "vsp"
end
