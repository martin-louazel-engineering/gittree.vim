if exists("b:current_syntax")
     finish
endif
let b:current_syntax = "gittree"

syn match gittreeSkip		/^...$/
syn match gittreeLine		/^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
syn match gittreeHead		/^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>\( ([^)]\+)\)\? \)\?/ contained containedin=gittreeLine
syn match gittreeHeadPtr	/HEAD\( ->\)\?/ contained containedin=gittreeRefs
syn match gittreeTag		/tag: [^,)]*/ contained containedin=gittreeRefs
syn match gittreeRemote		/[^,()]*\/[^,)]*/ contained containedin=gittreeRefs
syn match gittreeRefs		/([^)]*)/ contained containedin=gittreeHead
syn match gittreeHashAbbrev /\x\{7,\}/ contained containedin=gittreeHead nextgroup=gittreeRefs
syn match gittreeGraph		/^[_\*|\/\\ ]\+/ contained containedin=gittreeHead,gittreeCommit nextgroup=gittreeHashAbbrev skipwhite
hi def link gittreeHashAbbrev	Constant
hi def link gittreeGraph		Normal
hi def link gittreeRefs			Function
hi def link gittreeHeadPtr		Type
hi def link gittreeRemote		Keyword
hi def link gittreeTag			String
hi def link gittreeSkip			Comment
