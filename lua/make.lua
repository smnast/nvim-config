function Build_cpp()
    local filename = vim.fn.expand('%:p')
    local output_filename = vim.fn.expand('%:p:r')
    local command = string.format(
        'g++ -DLOCAL -include /usr/include/c++/13.2/x86_64-unknown-linux-gnu/bits/stdc++.h -Wall -Wextra "%s" -o "%s"',
        filename,
        output_filename
    )
    vim.api.nvim_command('! ' .. command)
end

function Run_cpp()
    local output_filename = vim.fn.expand('%:p:r')
    vim.cmd(':TermExec direction=horizontal cmd="' .. output_filename .. '" go_back=0')
end

function Run_python()
    local filename = vim.fn.expand('%:p')
    local command = string.format('python %s', filename)
    vim.cmd(':TermExec direction=horizontal cmd="' .. command .. '" go_back=0')
end

-- C++
vim.api.nvim_command([[autocmd FileType cpp nnoremap <buffer> <c-b> :lua Build_cpp()<CR>]])
vim.api.nvim_command([[autocmd FileType cpp nnoremap <buffer> <c-e> :lua Run_cpp()<CR>]])

-- Python
vim.api.nvim_command([[autocmd FileType python nnoremap <buffer> <c-e> :lua Run_python()<CR>]])

