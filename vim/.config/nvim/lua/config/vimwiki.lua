local M = {}

function M.setup()
  local g = vim.g
  g.vimwiki_list = {{
    path = "/Users/simonthompson/OneDrive - Genomics England Ltd/wiki",
    syntax = "markdown"
  }}

end

return M
