vim.cmd 'hi clear'
if vim.fn.exists 'syntax_on' == 1 then
  vim.cmd 'syntax reset'
end

vim.o.termguicolors = true
vim.g.colors_name = 'syntaxfm'

local hi = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

-- Palette
-- gold    = declaration keywords, numbers, constants, CSS selectors
-- lime    = control flow keywords (if/for/while/return/break), booleans
-- cyan    = members, properties, object access, HTML attributes, JSON/TOML keys
-- salmon  = errors, builtins (self/this), brackets, lifetimes, exceptions
-- blue    = functions, methods, HTML intrinsic elements (div/span/p)
-- green   = all string literals, regex, raw blocks
-- purple  = named types, structs, enums, classes, custom React components
-- comment = muted chrome, comments
local c = {
  bg       = '#111111',
  bg_float = '#0c0c0c',
  bg_sel   = '#1a1a1a',
  bg_vis   = '#2a2a2a',
  fg       = '#ffffff',
  comment  = '#666666',
  muted    = '#9a9a9a',
  type     = '#C678DD',
  gold     = '#FABF47',
  lime     = '#BEFF00',
  cyan     = '#00FFF5',
  salmon   = '#FF807F',
  green    = '#98C379',
  blue     = '#61AFEF',
  cream    = '#fdf4c1',
  teal     = '#518b8b',
  darkgold = '#a07d3a',
  mudgold  = '#a89984',
}

-- UI
hi('Normal',        { fg = c.fg,      bg = c.bg })
hi('NormalFloat',   { fg = c.fg,      bg = c.bg_float })
hi('FloatBorder',   { fg = c.gold,    bg = c.bg_float })
hi('CursorLine',    { bg = c.bg_sel })
hi('CursorLineNr',  { fg = c.gold,    bold = true })
hi('LineNr',        { fg = c.comment })
hi('SignColumn',    { bg = c.bg })
hi('EndOfBuffer',   { fg = c.bg })
hi('VertSplit',     { fg = c.bg_float })
hi('WinSeparator',  { fg = c.bg_float })
hi('StatusLine',    { fg = c.fg,      bg = c.bg_float })
hi('StatusLineNC',  { fg = c.comment, bg = c.bg_float })
hi('Pmenu',         { fg = c.fg,      bg = c.bg_float })
hi('PmenuSel',      { fg = c.bg,      bg = c.gold,    bold = true })
hi('Visual',        { bg = c.bg_vis })
hi('Search',        { fg = c.bg,      bg = c.gold })
hi('IncSearch',     { fg = c.bg,      bg = c.lime })
hi('MatchParen',    { fg = c.salmon,  bold = true })
hi('ColorColumn',   { bg = c.bg_float })
hi('Folded',        { fg = c.comment, bg = c.bg_float })
hi('Directory',     { fg = c.cyan })
hi('ErrorMsg',      { fg = c.salmon,  bold = true })
hi('WarningMsg',    { fg = c.gold,    bold = true })
hi('QuickFixLine',  { bg = c.bg_sel })
hi('Conceal',       { fg = c.comment })
hi('NonText',       { fg = c.comment })
hi('SpecialKey',    { fg = c.comment })

-- Core Syntax
hi('Comment',        { fg = c.comment })
hi('Constant',       { fg = c.gold })
hi('String',         { fg = c.green })
hi('Character',      { fg = c.green })
hi('Number',         { fg = c.gold })
hi('Boolean',        { fg = c.lime })
hi('Float',          { fg = c.gold })
hi('Identifier',     { fg = c.fg })
hi('Function',       { fg = c.blue })
hi('Statement',      { fg = c.lime })
hi('Conditional',    { fg = c.lime })
hi('Repeat',         { fg = c.lime })
hi('Label',          { fg = c.cyan })
hi('Operator',       { fg = c.fg })
hi('Keyword',        { fg = c.gold })
hi('Exception',      { fg = c.salmon })
hi('PreProc',        { fg = c.cream })
hi('Include',        { fg = c.gold })
hi('Define',         { fg = c.cream })
hi('Macro',          { fg = c.cream })
hi('PreCondit',      { fg = c.cream })
hi('Type',           { fg = c.type })
hi('StorageClass',   { fg = c.gold })
hi('Structure',      { fg = c.type })
hi('Typedef',        { fg = c.type })
hi('Special',        { fg = c.darkgold })
hi('SpecialChar',    { fg = c.mudgold })
hi('Tag',            { fg = c.type })
hi('Delimiter',      { fg = c.comment })
hi('SpecialComment', { fg = c.comment })
hi('Debug',          { fg = c.salmon })
hi('Underlined',     { fg = c.cyan,   underline = true })
hi('Bold',           { bold = true })
hi('Italic',         { italic = true })
hi('Error',          { fg = c.salmon })
hi('Todo',           { fg = c.bg,     bg = c.gold,    bold = true })

-- Diagnostics
hi('DiagnosticError',          { fg = c.salmon })
hi('DiagnosticWarn',           { fg = c.gold })
hi('DiagnosticInfo',           { fg = c.cyan })
hi('DiagnosticHint',           { fg = c.lime })
hi('DiagnosticUnderlineError', { undercurl = true, sp = c.salmon })
hi('DiagnosticUnderlineWarn',  { undercurl = true, sp = c.gold })
hi('DiagnosticUnderlineInfo',  { undercurl = true, sp = c.cyan })
hi('DiagnosticUnderlineHint',  { undercurl = true, sp = c.lime })

-- Treesitter — Variables
hi('@variable',           { fg = c.fg })
hi('@variable.builtin',   { fg = c.salmon })
hi('@variable.parameter', { fg = c.fg })
hi('@variable.member',    { fg = c.cyan })
hi('@property',           { fg = c.cyan })
hi('@field',              { fg = c.cyan })

-- Treesitter — Functions
hi('@function',             { fg = c.blue })
hi('@function.builtin',     { fg = c.blue })
hi('@function.call',        { fg = c.blue })
hi('@function.method',      { fg = c.blue })
hi('@function.method.call', { fg = c.blue })
hi('@constructor',          { fg = c.blue })
hi('@method',               { fg = c.blue })

-- Treesitter — Keywords
hi('@keyword',           { fg = c.gold })
hi('@keyword.function',  { fg = c.gold })
hi('@keyword.return',    { fg = c.lime })
hi('@keyword.operator',  { fg = c.fg })
hi('@keyword.modifier',  { fg = c.gold })
hi('@keyword.import',    { fg = c.gold })
hi('@keyword.export',    { fg = c.gold })
hi('@conditional',       { fg = c.lime })
hi('@repeat',            { fg = c.lime })
hi('@operator',          { fg = c.fg })

-- Treesitter — Types
hi('@type',            { fg = c.type })
hi('@type.builtin',    { fg = c.type })
hi('@type.definition', { fg = c.type })
hi('@type.qualifier',  { fg = c.lime })

-- Treesitter — Constants
hi('@constant',         { fg = c.gold })
hi('@constant.builtin', { fg = c.gold })
hi('@constant.macro',   { fg = c.cream })

-- Treesitter — Strings
hi('@string',         { fg = c.green })
hi('@string.escape',  { fg = c.green })
hi('@string.regex',   { fg = c.green, italic = true })
hi('@string.special', { fg = c.green })
hi('@character',      { fg = c.green })
hi('@number',         { fg = c.gold })
hi('@boolean',        { fg = c.lime })

-- Treesitter — Modules / Labels / Comments
hi('@module',         { fg = c.fg })
hi('@module.builtin', { fg = c.salmon })
hi('@label',          { fg = c.cyan })
hi('@comment',        { fg = c.comment })

-- Treesitter — Punctuation
hi('@punctuation',           { fg = c.fg })
hi('@punctuation.bracket',   { fg = c.salmon })
hi('@punctuation.delimiter', { fg = c.comment })
hi('@punctuation.special',   { fg = c.gold })

-- Treesitter — Tags (HTML/JSX/TSX)
-- @tag.builtin = lowercase HTML intrinsics (div, span, p, h1, input...)
-- @tag         = PascalCase custom components (Accordion, MyButton...)
hi('@tag',                { fg = c.type })
hi('@tag.builtin',        { fg = c.blue })
hi('@tag.attribute',      { fg = c.cyan })
hi('@tag.delimiter',      { fg = c.comment })

-- Treesitter — Markup (Markdown)
hi('@markup.heading',  { fg = c.gold,    bold = true })
hi('@markup.italic',   { fg = c.type,    italic = true })
hi('@markup.link',     { fg = c.cyan,    underline = true })
hi('@markup.raw',      { fg = c.green })
hi('@markup.list',     { fg = c.lime })
hi('@markup.strong',   { bold = true })

-- LSP Semantic Tokens — Base
hi('@lsp.type.macro',         { fg = c.gold })
hi('@lsp.type.enum',          { fg = c.type })
hi('@lsp.type.enumMember',    { fg = c.cyan })
hi('@lsp.type.struct',        { fg = c.type })
hi('@lsp.type.type',          { fg = c.type })
hi('@lsp.type.typeParameter', { fg = c.type,   italic = true })
hi('@lsp.type.parameter',     { fg = c.fg })
hi('@lsp.type.property',      { fg = c.cyan })
hi('@lsp.type.variable',      { fg = c.fg })
hi('@lsp.type.function',      { fg = c.blue })
hi('@lsp.type.method',        { fg = c.blue })
hi('@lsp.type.namespace',     { fg = c.fg })
hi('@lsp.type.interface',     { fg = c.type,   italic = true })
hi('@lsp.type.class',         { fg = c.type })
hi('@lsp.type.typeAlias',     { fg = c.type,   italic = true })
hi('@lsp.type.decorator',     { fg = c.gold })
hi('@lsp.type.selfKeyword',   { fg = c.salmon })
hi('@lsp.type.selfParameter', { fg = c.salmon })
hi('@lsp.type.clsParameter',  { fg = c.salmon })
hi('@lsp.type.builtinType',   { fg = c.type })
hi('@lsp.type.lifetime',      { fg = c.salmon, italic = true })
hi('@lsp.type.string',        { fg = c.green })
hi('@lsp.type.number',        { fg = c.gold })
hi('@lsp.type.boolean',       { fg = c.lime })
hi('@lsp.type.keyword',       { fg = c.gold })
hi('@lsp.type.operator',      { fg = c.fg })
hi('@lsp.type.comment',       { fg = c.comment })

-- LSP Semantic Token Modifiers
hi('@lsp.typemod.keyword.controlFlow',      { fg = c.lime })
hi('@lsp.typemod.variable.constant',        { fg = c.gold })
hi('@lsp.typemod.variable.static',          { fg = c.gold })
hi('@lsp.typemod.function.declaration',     { fg = c.blue })
hi('@lsp.typemod.method.declaration',       { fg = c.blue })
hi('@lsp.typemod.variable.defaultLibrary',  { fg = c.salmon })
hi('@lsp.typemod.function.defaultLibrary',  { fg = c.blue })

-- Plugin UI — Blink.cmp
hi('BlinkCmpLabel',           { fg = c.fg })
hi('BlinkCmpLabelDeprecated', { fg = c.comment, strikethrough = true })
hi('BlinkCmpLabelMatch',      { fg = c.lime,    bold = true })
hi('BlinkCmpMenu',            { fg = c.fg,      bg = c.bg_float })
hi('BlinkCmpMenuBorder',      { fg = c.gold,    bg = c.bg_float })
hi('BlinkCmpDoc',             { fg = c.fg,      bg = c.bg_float })
hi('BlinkCmpDocBorder',       { fg = c.gold,    bg = c.bg_float })
hi('BlinkCmpScrollBarThumb',  { bg = c.gold })
hi('BlinkCmpScrollBarGutter', { bg = c.bg_float })
hi('BlinkCmpKindFunction',    { fg = c.blue })
hi('BlinkCmpKindMethod',      { fg = c.blue })
hi('BlinkCmpKindConstructor', { fg = c.blue })
hi('BlinkCmpKindKeyword',     { fg = c.gold })
hi('BlinkCmpKindVariable',    { fg = c.fg })
hi('BlinkCmpKindField',       { fg = c.cyan })
hi('BlinkCmpKindProperty',    { fg = c.cyan })
hi('BlinkCmpKindClass',       { fg = c.type })
hi('BlinkCmpKindInterface',   { fg = c.type })
hi('BlinkCmpKindEnum',        { fg = c.type })
hi('BlinkCmpKindEnumMember',  { fg = c.cyan })
hi('BlinkCmpKindStruct',      { fg = c.type })
hi('BlinkCmpKindModule',      { fg = c.fg })
hi('BlinkCmpKindSnippet',     { fg = c.cream })
hi('BlinkCmpKindText',        { fg = c.green })
hi('BlinkCmpKindValue',       { fg = c.gold })
hi('BlinkCmpKindColor',       { fg = c.green })
hi('BlinkCmpKindUnit',        { fg = c.gold })
hi('BlinkCmpKindReference',   { fg = c.cyan })

-- Plugin UI — Telescope
hi('TelescopeNormal',         { fg = c.fg,      bg = c.bg_float })
hi('TelescopeBorder',         { fg = c.gold,    bg = c.bg_float })
hi('TelescopePromptBorder',   { fg = c.gold,    bg = c.bg_float })
hi('TelescopeResultsBorder',  { fg = c.gold,    bg = c.bg_float })
hi('TelescopePreviewBorder',  { fg = c.gold,    bg = c.bg_float })
hi('TelescopeSelection',      { fg = c.bg,      bg = c.gold,    bold = true })
hi('TelescopeSelectionCaret', { fg = c.gold })
hi('TelescopeMatching',       { fg = c.lime,    bold = true })
hi('TelescopePromptPrefix',   { fg = c.gold })
hi('TelescopePromptTitle',    { fg = c.bg,      bg = c.gold })
hi('TelescopeResultsTitle',   { fg = c.bg,      bg = c.gold })
hi('TelescopePreviewTitle',   { fg = c.bg,      bg = c.gold })

-- Plugin UI — Oil
hi('OilDir',         { fg = c.cyan,   bold = true })
hi('OilFile',        { fg = c.fg })
hi('OilLink',        { fg = c.gold })
hi('OilLinkTarget',  { fg = c.comment })
hi('OilCopy',        { fg = c.lime })
hi('OilMove',        { fg = c.gold })
hi('OilDelete',      { fg = c.salmon })
hi('OilCreate',      { fg = c.green })
hi('OilChange',      { fg = c.gold })

-- Plugin UI — Gitsigns
hi('GitSignsAdd',    { fg = c.lime })
hi('GitSignsChange', { fg = c.gold })
hi('GitSignsDelete', { fg = c.salmon })

-- Plugin UI — LSP
hi('LspInlayHint',      { fg = c.comment, italic = true })
hi('LspReferenceText',  { bg = c.bg_vis })
hi('LspReferenceRead',  { bg = c.bg_vis })
hi('LspReferenceWrite', { bg = '#333333' })

-- Plugin UI — Trouble
hi('TroubleNormal',  { fg = c.fg,      bg = c.bg })
hi('TroubleCount',   { fg = c.gold,    bold = true })
hi('TroubleSource',  { fg = c.comment })
hi('TroubleCode',    { fg = c.muted })

-- Language Fallback — HTML
hi('htmlTag',         { fg = c.comment })
hi('htmlTagName',     { fg = c.blue })   -- standard HTML elements stay blue
hi('htmlArg',         { fg = c.cyan })
hi('htmlString',      { fg = c.green })
hi('htmlEndTag',      { fg = c.comment })
hi('htmlSpecialChar', { fg = c.green })
hi('htmlLink',        { fg = c.cyan,   underline = true })
hi('htmlBold',        { bold = true })
hi('htmlItalic',      { italic = true })

-- Language Fallback — CSS
hi('cssTagName',        { fg = c.blue })
hi('cssClassName',      { fg = c.gold })
hi('cssIdentifier',     { fg = c.gold })
hi('cssPseudoClass',    { fg = c.lime })
hi('cssPseudoClassId',  { fg = c.lime })
hi('cssProp',           { fg = c.cyan })
hi('cssValueLength',    { fg = c.gold })
hi('cssValueInteger',   { fg = c.gold })
hi('cssValueNumber',    { fg = c.gold })
hi('cssColor',          { fg = c.green })
hi('cssStringQ',        { fg = c.green })
hi('cssStringQQ',       { fg = c.green })
hi('cssUnitDecorators', { fg = c.type })
hi('cssImportant',      { fg = c.salmon, bold = true })
hi('cssBraces',         { fg = c.salmon })
hi('cssSelectorOp',     { fg = c.fg })
hi('cssAttrRegion',     { fg = c.gold })
hi('cssMediaProp',      { fg = c.cyan })
hi('cssAnimationProp',  { fg = c.cyan })
hi('cssTransitionProp', { fg = c.cyan })

-- Language Fallback — JSON
hi('jsonKeyword', { fg = c.cyan })
hi('jsonString',  { fg = c.green })
hi('jsonNumber',  { fg = c.gold })
hi('jsonBoolean', { fg = c.lime })
hi('jsonNull',    { fg = c.lime })
hi('jsonBraces',  { fg = c.salmon })
hi('jsonQuote',   { fg = c.comment })

-- Language Fallback — TOML
hi('tomlKey',        { fg = c.cyan })
hi('tomlTable',      { fg = c.gold,    bold = true })
hi('tomlTableArray', { fg = c.gold,    bold = true })
hi('tomlString',     { fg = c.green })
hi('tomlInteger',    { fg = c.gold })
hi('tomlFloat',      { fg = c.gold })
hi('tomlBoolean',    { fg = c.lime })
hi('tomlDate',       { fg = c.type })
hi('tomlComment',    { fg = c.comment })

-- Language Fallback — Python
hi('pythonDecorator',     { fg = c.gold })
hi('pythonDecoratorName', { fg = c.gold })
hi('pythonBuiltin',       { fg = c.salmon })
hi('pythonException',     { fg = c.salmon })
hi('pythonExceptions',    { fg = c.type })
hi('pythonString',        { fg = c.green })
hi('pythonFString',       { fg = c.green })
hi('pythonNumber',        { fg = c.gold })

-- Language Fallback — Rust
hi('Trait',              { fg = c.type,   italic = true })
hi('rustAttribute',      { link = 'Macro' })
hi('rustDerive',         { link = 'Trait' })
hi('rustModPath',        { link = 'Identifier' })
hi('rustFuncCall',       { link = 'Function' })
hi('rustFuncName',       { link = 'Function' })
hi('rustCommentLineDoc', { link = 'Comment' })
hi('rustAssert',         { link = 'Macro' })
hi('rustPanic',          { link = 'Macro' })
hi('rustMacro',          { link = 'Macro' })
hi('rustSigil',          { fg = c.lime })
hi('rustLifetime',       { fg = c.salmon, italic = true })
hi('rustEnumVariant',    { fg = c.cyan })
hi('rustMacroVariable',  { fg = c.gold })
