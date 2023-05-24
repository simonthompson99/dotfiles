local M = {}

function M.setup()
	local iron = require("iron")
	local api = vim.api

	iron.core.setup {
		config = {
			should_map_plug = false,
			buflisted = true,
			repl_definition = {
					python = require("iron.fts.python").ipython,
				-- python = {
				-- 	command = { "ipython", "--no-confirm-exit" }
				-- },
				-- r = {
				-- 	command = {"r"}
				-- },
			},
		}
	}

	-- functions to send to REPL which are mapped in which-key
	api.nvim_create_user_command(
		'SendLineToREPL',
		function()
			iron.core.send_line()
			vim.cmd('normal j')
		end,
		{}
	)
	api.nvim_create_user_command(
		'SendSelectionToREPL',
		function()
			-- local iron = require('iron')
			iron.core.mark_visual()
			iron.core.send_mark()
			iron.core.send(vim.bo.filetype, {""})
		end,
		{}
	)
	api.nvim_create_user_command(
		'SendParagraphToREPL',
		function()
			vim.cmd('normal vip')
			iron.core.visual_send()
			iron.core.send(vim.bo.filetype, {""})
			vim.cmd('normal }j')
		end,
		{}
	)
	api.nvim_create_user_command(
		'SendFunctionToREPL',
		function()
			vim.cmd('normal vaf')
			iron.core.visual_send()
			iron.core.send(vim.bo.filetype, {""})
			vim.cmd('normal `>j')
		end,
		{}
	)
	api.nvim_create_user_command(
		'CloseREPL',
		function()
			-- local iron = require('iron')
			iron.core.close_repl(vim.bo.filetype)
		end,
		{}
	)

end

return M

