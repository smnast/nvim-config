local function term_exec(cmd)
  local term_cmd = string.format('TermExec direction=horizontal cmd="%s" go_back=0', cmd)
  vim.cmd(term_cmd)
end

local build_functions = {
  cpp = function()
    local filename = vim.fn.expand('%:p')
    local output_filename = vim.fn.expand('%:p:r')
    local command = string.format(
      'g++ -DLOCAL -include /usr/include/c++/13.2/x86_64-unknown-linux-gnu/bits/stdc++.h -Wall -Wextra "%s" -o "%s"',
      filename,
      output_filename
    )
    vim.api.nvim_command('! ' .. command)
  end,
}

local run_functions = {
  cpp = function()
    local cmd = vim.fn.expand('%:p:r')
    term_exec(cmd)
  end,
  python = function()
    local filename = vim.fn.expand('%:p')
    local cmd = string.format('python %s', filename)
    term_exec(cmd)
  end,
}

local function check_script(script)
  local f = io.open(script, 'r')
  if f == nil then
    print('the file was not found.')
    return false
  end
  io.close(f)
  return true
end

local function run_from_script(script)
  term_exec(script)
end

local function build_from_script(script)
  term_exec(script)
end

local function run_program()
  local shell_script = vim.fn.getcwd() .. '/run.sh'
  if check_script(shell_script) then
    run_from_script(shell_script)
    return
  end

  local filetype = vim.bo.filetype

  if run_functions[filetype] then
    run_functions[filetype]()
  else
    print("No run function defined for filetype: " .. filetype)
  end
end

local function build_program()
  local shell_script = vim.fn.getcwd() .. '/build.sh'
  if check_script(shell_script) then
    build_from_script(shell_script)
    return
  end

  local filetype = vim.bo.filetype

  if build_functions[filetype] then
    build_functions[filetype]()
  else
    print("No build function defined for filetype: " .. filetype)
  end
end

vim.keymap.set('n', '<c-b>', build_program, { desc = 'Build Program', silent = true })
vim.keymap.set('n', '<c-e>', run_program, { desc = 'Run Program', silent = true })
