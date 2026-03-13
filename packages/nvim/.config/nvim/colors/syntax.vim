hi clear
if exists('syntax_on')
  syntax reset
endif

set termguicolors
let g:colors_name = 'syntaxfm'

hi Normal guifg=#ffffff guibg=#111111
hi NormalFloat guifg=#ffffff guibg=#0c0c0c
hi FloatBorder guifg=#FABF47 guibg=#0c0c0c
hi CursorLine guibg=#1a1a1a
hi CursorLineNr guifg=#FABF47 gui=bold
hi LineNr guifg=#666666
hi SignColumn guibg=#111111
hi EndOfBuffer guifg=#111111
hi VertSplit guifg=#0c0c0c
hi WinSeparator guifg=#0c0c0c
hi StatusLine guifg=#ffffff guibg=#0c0c0c
hi StatusLineNC guifg=#666666 guibg=#0c0c0c
hi Pmenu guifg=#ffffff guibg=#0c0c0c
hi PmenuSel guifg=#111111 guibg=#FABF47 gui=bold
hi Visual guibg=#2a2a2a
hi Search guifg=#111111 guibg=#FABF47
hi IncSearch guifg=#111111 guibg=#BEFF00
hi MatchParen guifg=#FF807F gui=bold
hi ColorColumn guibg=#0c0c0c
hi Folded guifg=#666666 guibg=#0c0c0c
hi Directory guifg=#00FFF5
hi ErrorMsg guifg=#FF807F gui=bold
hi WarningMsg guifg=#FABF47 gui=bold

hi Comment guifg=#666666
hi Constant guifg=#FABF47
hi String guifg=#CCCCCC
hi Character guifg=#CCCCCC
hi Number guifg=#FABF47
hi Boolean guifg=#BEFF00
hi Float guifg=#FABF47

hi Identifier guifg=#ffffff
hi Function guifg=#FABF47

hi Statement guifg=#FABF47
hi Conditional guifg=#FABF47
hi Repeat guifg=#FABF47
hi Label guifg=#518b8b
hi Operator guifg=#BEFF00
hi Keyword guifg=#FABF47
hi Exception guifg=#FF807F

hi PreProc guifg=#fdf4c1
hi Include guifg=#FABF47
hi Define guifg=#fdf4c1
hi Macro guifg=#fdf4c1
hi PreCondit guifg=#fdf4c1

hi Type guifg=#9a9a9a
hi StorageClass guifg=#FABF47
hi Structure guifg=#9a9a9a
hi Typedef guifg=#9a9a9a

hi Special guifg=#a07d3a
hi SpecialChar guifg=#a89984
hi Tag guifg=#FABF47
hi Delimiter guifg=#d5c5a1
hi SpecialComment guifg=#666666
hi Debug guifg=#FF807F

hi Underlined guifg=#00FFF5 gui=underline
hi Bold gui=bold
hi Italic gui=italic

hi Error guifg=#FF807F
hi Todo guifg=#111111 guibg=#FABF47 gui=bold

hi DiagnosticError guifg=#FF807F
hi DiagnosticWarn guifg=#FABF47
hi DiagnosticInfo guifg=#00FFF5
hi DiagnosticHint guifg=#BEFF00

hi DiagnosticUnderlineError gui=undercurl guisp=#FF807F
hi DiagnosticUnderlineWarn gui=undercurl guisp=#FABF47
hi DiagnosticUnderlineInfo gui=undercurl guisp=#00FFF5
hi DiagnosticUnderlineHint gui=undercurl guisp=#BEFF00

hi @variable guifg=#ffffff
hi @variable.builtin guifg=#FF807F
hi @variable.parameter guifg=#ffffff
hi @variable.member guifg=#00FFF5

hi @property guifg=#00FFF5
hi @field guifg=#00FFF5

hi @function guifg=#FABF47
hi @function.builtin guifg=#FABF47
hi @function.call guifg=#FABF47
hi @function.method guifg=#FABF47
hi @function.method.call guifg=#FABF47
hi @constructor guifg=#518b8b
hi @method guifg=#FABF47

hi @keyword guifg=#FABF47
hi @keyword.function guifg=#FABF47
hi @keyword.return guifg=#FABF47
hi @keyword.operator guifg=#BEFF00
hi @keyword.modifier guifg=#FABF47
hi @conditional guifg=#FABF47
hi @repeat guifg=#FABF47

hi @operator guifg=#BEFF00

hi @string guifg=#CCCCCC
hi @string.escape guifg=#a89984
hi @string.regex guifg=#a07d3a
hi @string.special guifg=#a07d3a
hi @character guifg=#CCCCCC

hi @number guifg=#FABF47
hi @boolean guifg=#BEFF00

hi @type guifg=#9a9a9a
hi @type.builtin guifg=#9a9a9a
hi @type.definition guifg=#9a9a9a
hi @type.qualifier guifg=#FABF47

hi @constant guifg=#FABF47
hi @constant.builtin guifg=#FABF47
hi @constant.macro guifg=#fdf4c1

hi @module guifg=#ffffff
hi @module.builtin guifg=#FF807F
hi @label guifg=#518b8b

hi @comment guifg=#666666

hi @punctuation guifg=#ffffff
hi @punctuation.bracket guifg=#FF807F
hi @punctuation.delimiter guifg=#d5c5a1
hi @punctuation.special guifg=#d5c5a1

hi @tag guifg=#FABF47
hi @tag.attribute guifg=#FABF47

hi @markup.heading guifg=#fdf4c1 gui=bold
hi @markup.italic guifg=#a07d3a gui=italic
hi @markup.link guifg=#00FFF5 gui=underline
hi @markup.raw guifg=#a07d3a

" Rust-focused extras
hi @lsp.type.macro guifg=#fdf4c1
hi @lsp.type.enum guifg=#9a9a9a
hi @lsp.type.enumMember guifg=#518b8b
hi @lsp.type.struct guifg=#9a9a9a
hi @lsp.type.type guifg=#9a9a9a
hi @lsp.type.typeParameter guifg=#FF807F
hi @lsp.type.parameter guifg=#ffffff
hi @lsp.type.property guifg=#00FFF5
hi @lsp.type.variable guifg=#ffffff
hi @lsp.type.function guifg=#FABF47
hi @lsp.type.method guifg=#FABF47
hi @lsp.type.namespace guifg=#ffffff

hi link rustAttribute Macro
hi link rustDerive Trait
hi link rustModPath Identifier
hi link rustFuncCall Function
hi link rustFuncName Function
hi link rustCommentLineDoc Comment
hi link rustAssert Macro
hi link rustPanic Macro
hi link rustMacro Macro
hi link rustSigil SpecialChar

hi Trait guifg=#9a9a9a
