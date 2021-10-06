" some leader mappings for neoterm
nnoremap <buffer> <leader>dv :T mymodule.dtv(<C-R><C-W>)<cr> " dtv on word
nnoremap <buffer> <leader>rv :T mymodule.dtv(<C-R><C-W>.sample(1000))<cr> " rdtv on word
nnoremap <buffer> <leader>hd :T <C-R><C-W>.head()<cr> " head on word
nnoremap <buffer> <leader>dr :T dir(<C-R><C-W>)<cr> " dir on word
nnoremap <buffer> <leader>pp vap"+y:T %paste<cr>} " send current paragraph and move down

" turn on indent guides (not enabled by default)
IndentGuidesEnable

" effectively autocomplete apostrophe's which we might not want to do in all
" filetypes
inoremap ' ''<left>
