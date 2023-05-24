local M = {}

function M.setup()
  require("nvim-tree").setup {
    disable_netrw = false,
    hijack_netrw = false,
    view = {
      number = true,
      relativenumber = true,
    },
    filters = {
 --     custom = { ".git" },
    },
  }
end

return M
