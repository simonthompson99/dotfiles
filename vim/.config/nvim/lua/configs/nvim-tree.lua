local M = {}

function M.setup()

  local nvimtree = require("nvim-tree")

  nvimtree.setup({
    view = {
      width = 45,
    },
  })

end

return M
