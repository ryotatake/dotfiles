" inspired by https://github.com/vim-scripts/trac.vim/blob/master/syntax/trac.vim

if exists("b:current_syntax")
    finish
endif

syn clear
hi clear

" headings
syn match       tracHeader              /^\(=\{1,5}\).*$/

" inline markup
syn match       tracItalic              /\('\{2}\)[^']\+\1/
syn match       tracBold                /\('\{3}\)[^']\+\1/
syn match       tracBoldItalic          /\('\{5}\)[^']\+\1/
syn match       tracUnderline           /\(_\{2}\).\{-}\1/
syn match       tracSubscript           /\(,\{2}\).\{-}\1/
syn match       tracSuperscript         /\(\^\).\{-}\1/
syn match       tracTypewriter          /\(`\).\{-}\1/
syn match       tracMacro               /\[\{2}.\{-}\]\{2}/

" Codeblocks
syn region      tracPreformatted        start=/{{{/ end=/}}}/

" Links
syn match       tracWikiWord            /\(\w\+:\)\?\u[a-z0-9]\+\u[a-z0-9]\+\(\u[a-z0-9]\+\)*/
syn match       tracBracketLink         /\[[^[\]]\+\]/
syn match       tracSubLink             /\(\w\+\|\.\.\)\?\// nextgroup=tracWikiWord
syn match       tracNormalURL           /\w\+:\/\/\S\+/
syn match       tracEmail               /\S\+@\S\+/

" lists
syn match       tracBulletList          /^\(\s*\)\zs\*\ze\s/
syn match       tracBulletList          /^\(\s*\)\zs\-\ze\s/
syn match       tracNumberedList        /^\(\s*\)\zs1\.\ze\s/
syn match       tracAlphalist           /^\(\s*\)\zsa\.\ze\s/
syn match       tracRomanlist           /^\(\s*\)\zsi\.\ze\s/
syn match       tracBigromanlist        /^\(\s*\)\zsI\.\ze\s/
syn match       tracDescriptionlist     /^\(\s*\)\zs.\{-}::\ze\s/

" rules
syn match       tracRule                /^-\{4,}/

" comments/pragmas
syn match       tracComment             /^##.*$/
syn match       tracPragma              /^#\w\+.*$/

" Define the default highlighting.
command -nargs=+ HiLink hi def link <args>

HiLink      tracHeader              Title

HiLink      tracItalic              Identifier
HiLink      tracBold                Identifier
HiLink      tracBoldItalic          Identifier
HiLink      tracUnderline           Identifier
HiLink      tracSubscript           Identifier
HiLink      tracSuperscript         Identifier
HiLink      tracTypewriter          Identifier
HiLink      tracMacro               Define
HiLink      tracPragma              Define

HiLink      tracPreformatted        String

HiLink      tracWikiWord            Statement
HiLink      tracBracketLink         Statement
HiLink      tracNormalURL           Statement
HiLink      tracSubLink             Statement
HiLink      tracInterLink           Statement
HiLink      tracEmail               Statement

HiLink      tracBulletList          Type
HiLink      tracNumberedList        Type
HiLink      tracAlphalist           Type
HiLink      tracRomanlist           Type
HiLink      tracBigromanlist        Type
HiLink      tracDescriptionlist     Type

HiLink      tracRule                Special

HiLink      tracComment             Comment

delcommand HiLink

let b:current_syntax = "trac"
