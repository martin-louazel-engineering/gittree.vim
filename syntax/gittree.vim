if exists("b:current_syntax")
     finish
endif
let b:current_syntax = "gittree"

syn match gtSkip		/^...$/
syn match gtGraph		/^[_\*|\/\\ ]\+/ nextgroup=gtHashAbbrev skipwhite
syn match gtDiffLineRef /@@.*@@/
syn match gtDiffChange	/^[_\*|\/\\ ]\+ [+-]\{1}\([^+-].*\)\?$/ contains=gtDiffPlus,gtDiffMinus
syn match gtDiffMetaLine	/^[_\*|\/\\ ]\+ \(+++\|---\|diff\).*$/ contains=gtDiffMeta
syn match gtDiffMeta	/\(+++\|---\|diff\).*$/ contained
syn match gtDiffPlus	/+\(.*\)$/ contained containedin=gtDiffLine
syn match gtDiffMinus	/-\(.*\)$/ contained containedin=gtDiffLine
syn match gtHashAbbrev	/\x\{7,\}/ contained nextgroup=gtRefs skipwhite
syn match gtRefs		/([^)]*)/ contained nextgroup=gtMessage skipwhite
syn match gtBranch		/[^,()]*/ contained containedin=gtRefs
syn match gtRemote		/[^,()]*\/[^,)]*/ contained containedin=gtRefs
syn match gtTag			/tag: [^,)]*/ contained containedin=gtRefs
syn match gtHeadPtr		/HEAD\( ->\)\?/ contained containedin=gtRefs

hi def link gtSkip			Comment
hi def link gtGraph			Normal
hi def link gtDiffLineRef	Label
hi def link gtDiffPlus		Green
hi def link gtDiffMinus		Red
hi gtDiffMeta term=bold cterm=bold ctermfg=White gui=bold guifg=White
hi def link gtHashAbbrev	Constant
hi def link gtRefs			Character
hi def link gtHeadPtr		Type
hi def link gtBranch		Function
hi def link gtRemote		Keyword
hi def link gtTag			WarningMsg
