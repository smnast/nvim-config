-- NOTE: Commenter
return {
  "numToStr/Comment.nvim",
  lazy = false, -- This is necessary for the keybinds to work
  config = function()
    require("Comment").setup {
      ignore = "^$",
      toggler = {
          line = '<C-/>'
      },
      opleader = {
          line = '<C-/>'
      },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
  dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
}
