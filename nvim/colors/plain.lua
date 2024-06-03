local o = vim.o
local g = vim.g
local api = vim.api

vim.cmd('hi clear')

if g.syntax_on == 1 then
  vim.cmd('syntax reset')
end

g.colors_name = 'plain'

local background = '#f4f4f4'
local grey_bg_light = '#E5E5E5'
local black = '#676767'
local blue = '#6587bf'
local green = '#7c9f4b'
local light_green = '#6d8b42'
local light_red = '#c66666'
local red = '#db7070'
local grey = '#767676'
local light_grey = '#dfdfdf'
local border = '#999999'
local highlight = '#424242'
local dark_yellow = '#d69822'
local yellow = '#f3e430'
local light_yellow = '#fadaa0'
local orange = '#D75F5F'
local purple = '#523C79'
local white = '#FFFFFF'
local cyan = '#509c93'

g.terminal_color_0 = black
g.terminal_color_1 = red
g.terminal_color_2 = green
g.terminal_color_3 = dark_yellow
g.terminal_color_4 = blue
g.terminal_color_5 = purple
g.terminal_color_6 = cyan
g.terminal_color_7 = grey

g.terminal_color_8 = black
g.terminal_color_9 = red
g.terminal_color_10 = green
g.terminal_color_11 = dark_yellow
g.terminal_color_12 = blue
g.terminal_color_13 = purple
g.terminal_color_14 = cyan
g.terminal_color_15 = grey

local highlights = {
  -- This highlight group can be used when one wants to disable a highlight
  -- group using `winhl`
  Disabled = {},
  -- These highlight groups can be used for statuslines, for example when
  -- displaying ALE warnings and errors.
  BlackOnLightYellow = { fg = black, bg = light_yellow },
  LightRedBackground = { bg = light_red },
  WhiteOnBlue = { fg = white, bg = blue },
  WhiteOnOrange = { fg = white, bg = orange },
  WhiteOnRed = { fg = white, bg = red },
  WhiteOnYellow = { fg = white, bg = dark_yellow },
  Yellow = { fg = dark_yellow, bold = true },
  Bold = { fg = black, bold = true },
  Boolean = { link = 'Keyword' },
  Character = { link = 'String' },
  ColorColumn = { bg = highlight },
  Comment = { fg = grey },
  Conceal = {},
  Constant = { fg = black },
  Cursor = { bg = black },
  -- This is to work around https://github.com/neovim/neovim/issues/9800.
  CursorLine = { ctermfg = 'black' },
  CursorLineNr = { fg = black, bold = true },
  Directory = { fg = purple },
  EndOfBuffer = { fg = background, bg = background },
  Error = { link = 'ErrorMsg' },
  ErrorMsg = { fg = red, bold = true },
  FoldColumn = { fg = light_grey, bg = background },
  Folded = { link = 'Comment' },
  Identifier = { fg = black },
  Function = { fg = black },
  IncSearch = { link = 'Search' },
  CurSearch = { link = 'Search' },
  Include = { fg = black, bold = true },
  InstanceVariable = { fg = purple },
  Keyword = { fg = black, bold = true },
  Label = { link = 'Keyword' },
  LineNr = { fg = grey },
  Macro = { fg = orange },
  MatchParen = { bold = true },
  MoreMsg = { fg = black },
  ModeMsg = { fg = black, bold = true },
  MsgSeparator = { fg = border },
  NonText = { fg = grey },
  Normal = { fg = black , bg = background },
  NormalFloat = { fg = black },
  FloatTitle = { fg = black, bold = true },
  FloatBorder = { fg = border },
  Number = { fg = blue },
  Operator = { fg = black },
  Pmenu = { fg = black, bg = grey_bg_light },
  PmenuSbar = { bg = grey_bg_light },
  PmenuSel = { bg = light_grey, bold = true },
  PmenuThumb = { bg = light_grey },
  PreCondit = { link = 'Macro' },
  PreProc = { fg = black },
  Question = { fg = black },
  QuickFixLine = { bg = highlight, bold = true },
  Regexp = { fg = orange },
  Search = { bg = light_yellow },
  SignColumn = { link = 'FoldColumn' },
  Special = { fg = black },
  SpecialKey = { link = 'Number' },
  SpellBad = { sp = red, underline = true },
  SpellCap = { sp = dark_yellow, underline = true },
  SpellLocal = { sp = blue, underline = true },
  SpellRare = { sp = purple, underline = true },
  Statement = { link = 'Keyword' },
  StatusLine = { fg = black, bg = background },
  StatusLineNC = { fg = black, bg = grey_bg_light },
  StatusLineTab = { fg = black, bg = background, bold = true },
  WinBar = { fg = black, bold = true },
  WinBarNc = { fg = black, bold = true },
  WinBarFill = { fg = border },
  StorageClass = { link = 'Keyword' },
  String = { fg = cyan },
  SnippetTabstop = {},
  Symbol = { fg = orange },
  TabLine = { fg = black, bg = light_grey },
  TabLineFill = { fg = black, bg = light_grey },
  TabLineSel = { fg = black, bg = background, bold = true },
  Title = { fg = black, bold = true },
  Todo = { fg = grey, bold = true },
  Type = { link = 'Constant' },
  Underlined = { underline = true },
  VertSplit = { fg = border },
  WinSeparator = { fg = border },
  Visual = { bg = light_grey },
  WarningMsg = { fg = dark_yellow, bold = true },
  Whitespace = { fg = border },
  WildMenu = { link = 'PmenuSel' },
  -- ALE
  ALEError = { fg = red, bold = true },
  ALEErrorSign = { fg = red, bold = true },
  ALEWarning = { fg = dark_yellow, bold = true },
  ALEWarningSign = { fg = dark_yellow, bold = true },
  -- ccc.nvim
  CccFloatNormal = { link = 'NormalFloat' },
  CccFloatBorder = { link = 'FloatBorder' },
  -- CSS
  cssClassName = { link = 'Keyword' },
  cssColor = { link = 'Number' },
  cssIdentifier = { link = 'Keyword' },
  cssImportant = { link = 'Keyword' },
  cssProp = { link = 'Identifier' },
  cssTagName = { link = 'Keyword' },
  -- Diffs
  DiffAdd = { fg = green, bg = background },
  DiffChange = { bg = highlight },
  DiffDelete = { fg = red },
  DiffText = { bg = light_yellow },
  diffAdded = { link = 'DiffAdd' },
  diffChanged = { link = 'DiffChange' },
  diffFile = { fg = black, bold = true },
  diffLine = { fg = blue },
  diffRemoved = { link = 'DiffDelete' },
  -- Dot/Graphviz
  dotKeyChar = { link = 'Operator' },
  -- diffview.nvim
  DiffviewCursorLine = { bg = highlight },
  DiffviewDiffAddAsDelete = { bg = light_red },
  DiffviewDiffDelete = { fg = light_grey },
  DiffviewDiffDeleteDim = { fg = light_grey },
  DiffviewFilePanelFileName = { fg = black },
  DiffviewFilePanelPath = { fg = purple },
  DiffviewFilePanelRootPath = { fg = purple },
  DiffviewFilePanelTitle = { fg = black, bold = true },
  DiffviewFilePanelInsertions = { fg = green },
  DiffviewFilePanelDeletions = { fg = red },
  DiffviewStatusModified = { fg = dark_yellow, bold = true },
  DiffviewStatusAdded = { fg = green, bold = true },
  DiffviewStatusCopied = { fg = green, bold = true },
  DiffviewStatusDeleted = { fg = red, bold = true },
  -- Flash
  FlashBackdrop = { link = 'None' },
  FlashLabel = { fg = red, bold = true },
  -- Fugitive
  FugitiveblameHash = { fg = purple },
  FugitiveblameTime = { fg = blue },
  gitCommitOverflow = { link = 'ErrorMsg' },
  gitCommitSummary = { link = 'String' },
  -- gitcommit
  ['@string.special.url.gitcommit'] = { fg = black },
  ['@markup.link.gitcommit'] = { fg = green, bold = true },
  ['@comment.warning.gitcommit'] = { fg = red, bold = true },
  -- Gitsigns
  GitSignsAdd = { fg = green },
  GitSignsDelete = { fg = red },
  GitSignsChange = { fg = grey },
  -- HAML
  hamlClass = { fg = black },
  hamlDocType = { link = 'Comment' },
  hamlId = { fg = black },
  hamlTag = { fg = black, bold = true },
  -- hop.nvim
  HopNextKey = { fg = red, bold = true },
  HopNextKey1 = { fg = dark_yellow },
  HopNextKey2 = { fg = dark_yellow },
  HopUnmatched = {},
  -- HTML
  htmlArg = { link = 'Identifier' },
  htmlLink = { link = 'Directory' },
  htmlScriptTag = { link = 'htmlTag' },
  htmlSpecialTagName = { link = 'htmlTag' },
  htmlTag = { fg = black, bold = true },
  htmlTagName = { link = 'htmlTag' },
  htmlItalic = { italic = true },
  htmlBold = { bold = true },
  -- Inko
  inkoCommentBold = { fg = grey, bold = true },
  inkoCommentInlineUrl = { link = 'Number' },
  inkoCommentItalic = { fg = grey, italic = true },
  inkoCommentTitle = { fg = grey, bold = true },
  inkoInstanceVariable = { link = 'InstanceVariable' },
  inkoKeywordArgument = { link = 'Regexp' },
  ['@variable.member.inko'] = { link = 'InstanceVariable' },
  ['@constant.builtin.inko'] = { link = 'Keyword' },
  -- Java
  javaAnnotation = { link = 'Directory' },
  javaCommentTitle = { link = 'javaComment' },
  javaDocParam = { link = 'Todo' },
  javaDocTags = { link = 'Todo' },
  javaExternal = { link = 'Keyword' },
  javaStorageClass = { link = 'Keyword' },
  -- Javascript
  JavaScriptNumber = { link = 'Number' },
  javaScriptBraces = { link = 'Operator' },
  javaScriptFunction = { link = 'Keyword' },
  javaScriptIdentifier = { link = 'Keyword' },
  javaScriptMember = { link = 'Identifier' },
  -- JSON
  jsonKeyword = { link = 'String' },
  -- Lua
  luaFunction = { link = 'Keyword' },
  -- LSP
  DiagnosticUnderlineError = { underline = true, sp = red },
  DiagnosticUnderlineWarn = { underline = true, sp = dark_yellow },
  LspDiagnosticsUnderlineError = { link = 'DiagnosticUnderlineError' },
  LspDiagnosticsUnderlineWarning = { link = 'DiagnosticUnderlineWarn' },
  DiagnosticFloatingError = { fg = red, bold = true },
  DiagnosticFloatingHint = { fg = black, bold = true },
  DiagnosticFloatingInfo = { fg = blue, bold = true },
  DiagnosticFloatingWarn = { fg = dark_yellow, bold = true },
  DiagnosticError = { fg = red, bold = true },
  DiagnosticHint = { fg = grey, bold = true },
  DiagnosticInfo = { fg = blue, bold = true },
  DiagnosticWarn = { fg = dark_yellow, bold = true },
  -- Make
  makeTarget = { link = 'Function' },
  -- Markdown
  markdownCode = { link = 'markdownCodeBlock' },
  markdownCodeBlock = { link = 'Comment' },
  markdownListMarker = { link = 'Keyword' },
  markdownOrderedListMarker = { link = 'Keyword' },
  markdownUrl = { fg = blue },
  -- mini.pick
  MiniPickBorder = { fg = border },
  MiniPickBorderBusy = { link = 'MiniPickBorder' },
  MiniPickBorderText = { fg = black },
  MiniPickHeader = { fg = black, bold = true },
  MiniPickMatchCurrent = { bg = light_grey, bold = true },
  MiniPickMatchRanges = { fg = dark_yellow, bold = true },
  MiniPickNormal = { fg = black },
  MiniPickPrompt = { fg = black, bold = true },
  -- netrw
  netrwClassify = { link = 'Identifier' },
  -- Neogit
  NeogitBranch = { fg = green, bold = true },
  NeogitBranchHead = { link = 'NeogitBranch' },
  NeogitCommitViewHeader = { fg = dark_yellow, bold = true },
  NeogitCursorLine = { bg = highlight },
  NeogitDiffAdd = { link = 'DiffAdd' },
  NeogitDiffAddHighlight = { link = 'NeogitDiffAdd' },
  NeogitDiffContext = { link = 'Normal' },
  NeogitDiffContextHighlight = { link = 'Normal' },
  NeogitDiffDelete = { link = 'DiffDelete' },
  NeogitDiffDeleteHighlight = { link = 'NeogitDiffDelete' },
  NeogitDiffHeader = { fg = black, bold = true },
  NeogitDiffHeaderHighlight = { link = 'NeogitDiffHeader' },
  NeogitFilePath = { fg = purple },
  NeogitGraphBlue = { fg = blue },
  NeogitGraphBoldBlue = { fg = blue, bold = true },
  NeogitGraphBoldCyan = { fg = cyan, bold = true },
  NeogitGraphBoldGray = { fg = grey, bold = true },
  NeogitGraphBoldGreen = { fg = green, bold = true },
  NeogitGraphBoldOrange = { fg = orange, bold = true },
  NeogitGraphBoldPurple = { fg = purple, bold = true },
  NeogitGraphBoldRed = { fg = red, bold = true },
  NeogitGraphBoldWhite = { fg = black, bold = true },
  NeogitGraphBoldYellow = { fg = dark_yellow, bold = true },
  NeogitGraphCyan = { fg = cyan },
  NeogitGraphGray = { fg = grey },
  NeogitGraphGreen = { fg = green },
  NeogitGraphOrange = { fg = orange },
  NeogitGraphPurple = { fg = purple },
  NeogitGraphRed = { fg = red },
  NeogitGraphWhite = { fg = black },
  NeogitGraphYellow = { fg = dark_yellow },
  NeogitHunkHeader = { fg = blue },
  NeogitHunkHeaderHighlight = { link = 'NeogitHunkHeader' },
  NeogitPopupActionKey = { link = 'NeogitPopupOptionKey' },
  NeogitPopupBranchName = { link = 'NeogitBranch' },
  NeogitPopupConfigEnabled = { link = 'NeogitPopupOptionEnabled' },
  NeogitPopupConfigKey = { link = 'NeogitPopupOptionKey' },
  NeogitPopupOptionEnabled = { bg = light_green, bold = true },
  NeogitPopupOptionKey = { bold = true },
  NeogitPopupSectionTitle = { link = 'Title' },
  NeogitPopupSwitchEnabled = { link = 'NeogitPopupOptionEnabled' },
  NeogitPopupSwitchKey = { link = 'NeogitPopupOptionKey' },
  NeogitRemote = { link = 'NeogitBranch' },
  -- Perl
  perlPackageDecl = { link = 'Identifier' },
  perlStatementInclude = { link = 'Statement' },
  perlStatementPackage = { link = 'Statement' },
  podCmdText = { link = 'Todo' },
  podCommand = { link = 'Comment' },
  podVerbatimLine = { link = 'Todo' },
  -- Ruby
  rubyAttribute = { link = 'Identifier' },
  rubyClass = { link = 'Keyword' },
  rubyClassVariable = { link = 'rubyInstancevariable' },
  rubyConstant = { link = 'Constant' },
  rubyDefine = { link = 'Keyword' },
  rubyFunction = { link = 'Function' },
  rubyInstanceVariable = { link = 'InstanceVariable' },
  rubyMacro = { link = 'Identifier' },
  rubyModule = { link = 'rubyClass' },
  rubyRegexp = { link = 'Regexp' },
  rubyRegexpCharClass = { link = 'Regexp' },
  rubyRegexpDelimiter = { link = 'Regexp' },
  rubyRegexpQuantifier = { link = 'Regexp' },
  rubyRegexpSpecial = { link = 'Regexp' },
  rubyStringDelimiter = { link = 'String' },
  rubySymbol = { link = 'Symbol' },
  -- Rust
  rustCommentBlockDoc = { link = 'Comment' },
  rustCommentLineDoc = { link = 'Comment' },
  rustFuncCall = { link = 'Identifier' },
  rustModPath = { link = 'Identifier' },
  ['@function.macro.rust'] = { link = 'Macro' },
  ['@attribute.rust'] = { link = 'Identifier' },
  -- pounce.nvim
  PounceAccept = { fg = black, bg = yellow, bold = true },
  PounceAcceptBest = { link = 'PounceAccept' },
  PounceMatch = { bg = light_yellow },
  PounceUnmatched = {},
  PounceGap = { link = 'None' },
  -- Python
  pythonOperator = { link = 'Keyword' },
  -- SASS
  sassClass = { link = 'cssClassName' },
  sassId = { link = 'cssIdentifier' },
  -- Shell
  shFunctionKey = { link = 'Keyword' },
  -- Snippy
  SnippyPlaceholder = { link = 'SnippetTabstop' },
  -- SQL
  sqlKeyword = { link = 'Keyword' },
  -- Typescript
  typescriptBraces = { link = 'Operator' },
  typescriptEndColons = { link = 'Operator' },
  typescriptExceptions = { link = 'Keyword' },
  typescriptFuncKeyword = { link = 'Keyword' },
  typescriptFunction = { link = 'Function' },
  typescriptIdentifier = { link = 'Identifier' },
  typescriptLogicSymbols = { link = 'Operator' },
  -- Telescope
  TelescopeBorder = { fg = border },
  TelescopeMatching = { fg = dark_yellow, bold = true },
  TelescopePromptNormal = { fg = black },
  TelescopePromptBorder = { fg = border },
  TelescopePromptPrefix = { fg = black, bold = true },
  TelescopeSelection = { bg = light_grey, bold = true },
  TelescopeTitle = { fg = black, bold = true },
  TelescopeNormal = { fg = black },
  -- Treesitter
  TSEmphasis = { italic = true },
  TSField = {},
  TSStringEscape = { fg = green, bold = true },
  TSStrong = { bold = true },
  TSURI = { fg = blue, underline = true },
  TSUnderline = { underline = true },
  TSConstMacro = { link = 'Macro' },
  TSDanger = { link = 'Todo' },
  TSKeywordOperator = { link = 'Keyword' },
  TSNamespace = { link = 'Constant' },
  TSNote = { link = 'Todo' },
  TSProperty = { link = 'TSField' },
  TSStringRegex = { link = 'Regexp' },
  TSSymbol = { link = 'Symbol' },
  TSTypeBuiltin = { link = 'Keyword' },
  TSWarning = { link = 'Todo' },
  ['@markup.link'] = { fg = blue },
  ['@property.json'] = { bold = true },
  ['@text.emphasis'] = { italic = true },
  ['@text.reference'] = { fg = purple },
  ['@text.strong'] = { bold = true },
  ['@text.uri'] = { fg = blue },
  ['@variable.builtin'] = { bold = true },

  -- Custom Tree-sitter captures added by this theme.
  ['@variable.parameter.reference'] = { fg = orange },

  -- Ruby uses "TSLabel" for instance variables, for some reason. See
  -- https://github.com/tree-sitter/tree-sitter-ruby/issues/184 for more
  -- details.
  rubyTSLabel = { link = 'InstanceVariable' },
  -- TOML
  --
  -- tomlTSTypeBuiltin is used for section titles (e.g. `[dependencies]`), while
  -- tomlTSProperty is used for key-value pairs. These rules ensure the syntax
  -- is consistent with https://github.com/cespare/vim-toml.
  tomlTSProperty = { fg = black },
  tomlTSTypeBuiltin = { fg = black, bold = true },
  -- Vimscript
  VimCommentTitle = { link = 'Todo' },
  VimIsCommand = { link = 'Constant' },
  vimGroup = { link = 'Constant' },
  vimHiGroup = { link = 'Constant' },
  -- XML
  xmlAttrib = { link = 'Identifier' },
  xmlTag = { link = 'Identifier' },
  xmlTagName = { link = 'Identifier' },
  -- YAML
  yamlPlainScalar = { link = 'String' },
  -- YARD
  yardComment = { link = 'Comment' },
  yardType = { link = 'Todo' },
  yardTypeList = { link = 'Todo' },

  -- custom highlight groups
  ['@variable'] = { fg = black },
}

for group, opts in pairs(highlights) do
  api.nvim_set_hl(0, group, opts)
end
