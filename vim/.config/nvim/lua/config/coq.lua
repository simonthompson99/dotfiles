local M = {}

function M.setup()
  local coq = require "coq"
  coq.Now() -- Start coq
	-- need to prevent coq from remapping C-h (which I want to be used for switch panes)
	vim.g.coq_settings = {
		keymap = {
			jump_to_mark = ''
		}
	}

end

return M
