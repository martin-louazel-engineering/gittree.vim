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
syn match gtTag			/\s\?tag: [^,)]*/ contained containedin=gtRefs
syn match gtHeadPtr		/HEAD\( ->\)\?/ contained containedin=gtRefs

hi def link gtSkip			Comment
hi def link gtGraph			Normal
hi gtDiffLineRef			guifg=#75B5AA
hi def link gtDiffPlus		Green
hi def link gtDiffMinus		Red
hi gtDiffMeta		term=bold cterm=bold ctermfg=White gui=bold guifg=White
hi gtHashAbbrev		guifg=#F4BF75
hi gtRefs			guifg=#F4BF75
hi gtHeadPtr		guifg=#689F97
hi gtBranch			guifg=#90A959
hi gtRemote			guifg=#AC4242
hi gtTag			term=bold guifg=#F1BD74
