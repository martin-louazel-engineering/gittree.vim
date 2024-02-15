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

function! s:warn(message)
  echohl WarningMsg | echom a:message | echohl None
endfunction

let s:format = "%h%d %s"

function! gittree#sha(...)
	return matchstr(getline('.'), '[a-f0-9]\{7,\}')
endfunction

function! s:git_command(cmd)
	let sha = gittree#sha()
	if !empty(sha)
		execute "G ".a:cmd." ".sha
	else
		call s:warn("Commit SHA not found")
	endif
endfunction

function! s:mappings()
	nnoremap <silent> <buffer> <CR>			:call <sid>git_command("show")<CR>
	nnoremap <silent> <buffer> o			:call <sid>git_command("show")<CR>
	nnoremap <silent> <buffer> <leader>gc	:call <sid>git_command("checkout")<CR>
	nnoremap <silent> <buffer> <leader>gp	:call <sid>git_command("cherry-pick")<CR>
	nnoremap <silent> <buffer> <leader>gr	:call <sid>git_command("revert")<CR>
	nnoremap <silent> <buffer> <leader>gf	:<C-U>call <sid>git_command("format-patch -".v:count1)<CR>
	nnoremap <silent> <buffer> <leader>gs	:Git switch <cword><CR>
	nnoremap <silent> <buffer> <leader>gm	:Git merge <cword><CR>
endfunction

function! s:setupBuffer(args)
	" Only create a new buffer if not already on Gittree buffer, otherwise go
	" to it
	let l:bufName="GT"
	if strlen(a:args)
		let l:bufName=l:bufName." ".escape(a:args, " %")
	endif
	if buflisted(l:bufName) > 0
		execute "buffer" bufnr(l:bufName)
	else
		enew
		setlocal iskeyword+=-
		setlocal iskeyword+=/
		setlocal nowrap
		setlocal noswapfile
		execute "file ".l:bufName
		call s:mappings()
	endif
endfunction


function! s:gittree(args)
	let l:logArgs = expandcmd(a:args)
	let l:logCmd='git log --color=never --format="'.escape(s:format,"%").'" --graph '.escape(l:logArgs,"%")

	call s:setupBuffer(l:logArgs)

	setlocal modifiable
	%delete _
	silent execute 'read!'.l:logCmd
	silent execute '%s/\s\+$//e'
	normal! gg"_dd
	setlocal nomodifiable
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setf gittree
endfunction

command! -nargs=* -complete=customlist,fugitive#CompleteObject GT call s:gittree(<q-args>)
