vim.cmd([[
    hi Identifier guifg=#e6d9f1 guibg=NONE guisp=NONE gui=NONE
    hi Keyword guifg=#f1a6e5 guibg=NONE guisp=NONE gui=NONE
    hi Statement guifg=#e1a2bf guibg=NONE guisp=NONE gui=NONE
    hi Function guifg=#f2ae73 guibg=NONE guisp=NONE gui=NONE
    hi PreProc guifg=#c285d3 guibg=NONE guisp=NONE gui=NONE
    hi Constant guifg=#e4a487 guibg=NONE guisp=NONE gui=NONE
    hi Type guifg=#f38cb7 guibg=NONE guisp=NONE gui=NONE
    hi Comment guifg=#ada3b5 guibg=NONE guisp=NONE gui=NONE

    hi! link Label Identifier
    hi! link Operator Identifier
    hi! link StorageClass Keyword
    hi! link Structure Keyword
    hi! link Typedef Keyword
    hi! link Conditional Statement
    hi! link Repeat Statement
    hi! link Macro PreProc
    hi! link Include PreProc
    hi! link Delimeter Operator
    hi! link SpecialComment Comment
]])
