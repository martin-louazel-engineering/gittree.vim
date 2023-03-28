" The MIT License (MIT)
"
" Copyright (c) 2023 Martin Louazel
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

let s:begin = '^[^0-9]*\s\+'
let s:format = "%h%d %s"

function! gittree#sha(...)
	return matchstr(get(a:000, 0, getline('.')), s:begin.'\zs[a-f0-9]\+')
endfunction

function! s:open()
	let sha = gittree#sha()
	if !empty(sha)
		execute "G show ".sha
	else
		echo "Commit SHA not found"
	endif
endfunction

function! s:mappings()
	nnoremap <buffer> <CR>	:call <sid>open()<CR>
	nnoremap <buffer> o		:call <sid>open()<CR>
	nnoremap <buffer> <leader>gc :Git checkout <cword><CR>
	nnoremap <buffer> <leader>gp :Git cherry-pick <cword><CR>
	nnoremap <buffer> <leader>gr :Git revert <cword><CR>
endfunction

function! s:setupBuffer(args)
	" Only create a new buffer if not already on Gittree buffer, otherwise go
	" to it
	let l:bufName=trim("Gittree\ ".escape(a:args, " "))
	if buflisted(l:bufName) > 0
		execute "buffer" bufnr(l:bufName)
	else
		enew
		execute "file ".l:bufName
		call s:mappings()
	endif
endfunction


function! s:gittree(args)
	let l:logArgs = expand(a:args)
	let l:logCmd='git log --color=never --format="'.escape(s:format,"%").'" --graph '.l:logArgs

	call s:setupBuffer(l:logArgs)

	setlocal modifiable
	%delete _
	silent execute 'read!'.l:logCmd
	normal! gg"_dd
	setlocal nomodifiable
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setf gittree
endfunction

command! -nargs=* -complete=customlist,fugitive#Complete GT call s:gittree(<q-args>)
