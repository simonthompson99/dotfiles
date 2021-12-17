" turn off colorcolumn
setlocal colorcolumn=

" don't like having the coc autocomplete suggestions on in markdown
" let b:coc_suggest_disable = 1

" Write the current buffer to a temp file add html prefix and suffix to open
" in Firefox
" uses Strapdown.js - https://strapdownjs.com/
function! MdPreviewOld()
    " define all the variables
    let l:prefix_html = '<!DOCTYPE html> <html> <xmp theme="spacelab" style="display:none;">'
    let l:suffix_html = '</xmp> <script src="http://strapdownjs.com/v/0.2/strapdown.js"></script> </html>'
    let l:tmp_md_file = tempname() . '.md'
    let l:tmp_html_file = tempname() . '.html'
    " write out the buffer as it is to a temp file
    silent execute 'write ' . l:tmp_md_file
    " start a new scratch buffer
    new
    setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
    " put the prefix html into the buffer, then read in the temp md file then
    " go to the bottom and put the suffix in, then write it out to the temp
    " html file
    put=l:prefix_html
    execute 'read ' . l:tmp_md_file
    normal G
    put=l:suffix_html
    execute 'write ' . l:tmp_html_file
    " quit the scratch buffer
    q
    " tell OS to open the tmp html file
    silent execute '!open ' . l:tmp_html_file
endfunction

" open buffer in Firefox so that markdown extension will display it
function! MdPreview()
    silent execute '!open -a "Firefox.app" "%"'
endfunction

" export out current file to docx
function! MdToDocx()
    let l:tmp_docx_file = tempname() . '.docx'
    silent execute '!pandoc -o ' . l:tmp_docx_file . ' "%" -f markdown --from markdown-yaml_metadata_block'
    silent execute '!open ' . l:tmp_docx_file
endfunction

" make a mapping
nnoremap <buffer> <leader>pv :call MdPreview()<CR>

" mapping to go into and out of Goyo mode
nnoremap <buffer> <leader>gy :Goyo<CR>
