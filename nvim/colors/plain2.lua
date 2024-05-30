vim.cmd('hi clear')

if vim.fn.exists('syntax on') == 1 then
    vim.cmd('syntax reset')
end

vim.g.colors_name = 'plain2'

local colors = {
    black = { gui = "#222222", cterm = "0" },
    medium_gray = { gui = "#767676", cterm = "8" },
    white = { gui = "#F1F1F1", cterm = "7" },
    actual_white = { gui = "#FFFFFF", cterm = "15" },
    light_black = { gui = "#424242", cterm = "11" },
    lighter_black = { gui = "#545454", cterm = "12" },
    subtle_black = { gui = "#303030", cterm = "11" },
    light_gray = { gui = "#999999", cterm = "12" },
    lighter_gray = { gui = "#CCCCCC", cterm = "7" },
    lightest_gray = { gui = "#E5E5E5", cterm = "13" },
    pink = { gui = "#FB007A", cterm = "5" },
    dark_red = { gui = "#C30771", cterm = "1" },
    light_red = { gui = "#E32791", cterm = "1" },
    orange = { gui = "#D75F5F", cterm = "9" },
    darker_blue = { gui = "#005F87", cterm = "4" },
    dark_blue = { gui = "#008EC4", cterm = "4" },
    blue = { gui = "#20BBFC", cterm = "4" },
    light_blue = { gui = "#B6D6FD", cterm = "4" },
    dark_cyan = { gui = "#20A5BA", cterm = "6" },
    light_cyan = { gui = "#4FB8CC", cterm = "6" },
    dark_green = { gui = "#10A778", cterm = "6" },
    light_green = { gui = "#5FD7A7", cterm = "6" },
    dark_purple = { gui = "#523C79", cterm = "5" },
    light_purple = { gui = "#6855DE", cterm = "5" },
    light_yellow = { gui = "#F3E430", cterm = "3" },
    dark_yellow = { gui = "#A89C14", cterm = "3" },
}

local bg, bg_subtle, bg_very_subtle, norm, norm_subtle, purple, cyan, green, red, yellow, visual, cursor_line, status_line, status_line_nc, constant, comment, selection, warning

if vim.o.background == "dark" then
    bg = colors.white
    bg_subtle = colors.lighter_gray
    bg_very_subtle = colors.light_gray
    norm = colors.light_black
    norm_subtle = colors.lighter_black
    purple = colors.dark_purple
    cyan = colors.dark_cyan
    green = colors.dark_green
    red = colors.dark_red
    yellow = colors.dark_yellow
    visual = colors.light_blue
    cursor_line = colors.medium_gray
    status_line = colors.lighter_gray
    status_line_nc = colors.lighter_black
    constant = colors.dark_blue
    comment = colors.light_gray
    selection = colors.light_yellow
    warning = colors.yellow
else
    bg = colors.black
    bg_subtle = colors.light_black
    bg_very_subtle = colors.subtle_black
    norm = colors.lighter_gray
    norm_subtle = colors.light_gray
    purple = colors.light_purple
    cyan = colors.light_cyan
    green = colors.light_green
    red = colors.light_red
    yellow = colors.light_yellow
    visual = colors.subtle_black
    cursor_line = colors.subtle_black
    status_line = colors.lighter_black
    status_line_nc = colors.subtle_black
    constant = colors.light_green
    comment = colors.lighter_black
    selection = colors.light_purple
    warning = colors.yellow
end

local highlights = {
    firstAccent = { fg = cyan },
    secondAccent = { fg = purple },
    Normal = { fg = norm },
    Noise = { fg = norm_subtle },
    Cursor = { bg = green, fg = norm },
    Comment = { fg = comment, cterm = "italic" },
    Function = { fg = norm, cterm = "bold" },
    FloatWin = { fg = norm, bg = colors.black },
    Constant = { link = "firstAccent" },
    Character = { link = "Constant" },
    Number = { link = "Constant" },
    Boolean = { link = "Constant" },
    Float = { link = "Constant" },
    String = { link = "Constant" },
    Identifier = { link = "Normal" },
    Statement = { link = "Normal" },
    Conditonal = { link = "Statement" },
    Repeat = { link = "Statement" },
    Label = { link = "Statement" },
    Operator = { link = "Noise" },
    Keyword = { link = "Statement" },
    Exception = { link = "Statement" },
    PreProc = { link = "Normal" },
    Include = { link = "Statement" },
    Define = { link = "PreProc" },
    Macro = { link = "PreProc" },
    PreCondit = { link = "PreProc" },
    Type = { link = "secondAccent" },
    StorageClass = { link = "Type" },
    Structure = { link = "Noise" },
    Typedef = { link = "Noise" },
    Special = { link = "StatusLine" },
    SpecialChar = { link = "Special" },
    Tag = { link = "Special" },
    Delimiter = { link = "Special" },
    SpecialComment = { link = "Special" },
    Debug = { link = "Special" },
    Conceal = { link = "NonText" },
    Underlined = { fg = norm, gui = "underline", cterm = "underline" },
    Ignore = { fg = bg },
    Error = { fg = red, cterm = "bold" },
    Todo = { fg = colors.actual_white, bg = colors.black, gui = "bold", cterm = "bold" },
    SpecialKey = { fg = colors.subtle_black },
    NonText = { fg = bg_very_subtle },
    Directory = { fg = green },
    ErrorMsg = { fg = colors.pink },
    IncSearch = { bg = selection, fg = colors.black },
    Search = { bg = selection, fg = colors.black },
    MoreMsg = { fg = colors.medium_gray, cterm = "bold", gui = "bold" },
    ModeMsg = { link = "MoreMsg" },
    LineNr = { fg = colors.medium_gray },
    CursorLineNr = { fg = green, bg = bg_very_subtle },
    Question = { fg = red },
    VertSplit = { bg = bg, fg = bg_very_subtle },
    Title = { fg = green },
    Visual = { bg = visual },
    VisualNOS = { bg = bg_subtle },
    WarningMsg = { fg = warning },
    WildMenu = { fg = colors.white, bg = bg },
    Folded = { fg = colors.medium_gray },
    FoldColumn = { fg = bg_subtle },
    DiffAdd = { fg = green },
    DiffDelete = { fg = red },
    DiffChange = { fg = yellow },
    DiffText = { fg = green },
    SignColumn = { fg = colors.medium_gray },
    SpellBad = { gui = "underline", sp = red },
    SpellCap = { gui = "underline", sp = light_green },
    SpellRare = { gui = "underline", sp = colors.pink },
    SpellLocal = { gui = "underline", sp = green },
    StatusLine = { fg = status_line },
    StatusLineNC = { fg = status_line_nc },
    StatusLineOk = { gui = "underline", bg = bg, fg = green },
    StatusLineError = { gui = "underline", bg = bg, fg = colors.pink },
    StatusLineWarning = { gui = "underline", bg = bg, fg = warning },
    Pmenu = { fg = norm, bg = bg_subtle },
    PmenuSel = { fg = green, bg = bg_very_subtle, gui = "bold" },
    PmenuSbar = { fg = norm, bg = bg_subtle },
    PmenuThumb = { fg = norm, bg = bg_subtle },
    TabLine = { fg = norm_subtle, bg = bg },
    TabLineSel = { fg = norm, bg = bg, gui = "bold", cterm = "bold" },
    TabLineFill = { fg = norm_subtle, bg = bg },
    CursorColumn = { bg = bg_very_subtle },
    CursorLine = { bg = cursor_line },
    ColorColumn = { bg = bg_subtle },
    MatchParen = { bg = bg_very_subtle, fg = norm, cterm = "bold" },
    qfLineNr = { link = "secondAccent" },
    qfFileName = { link = "firstAccent" },
    htmlH1 = { fg = norm },
    htmlH2 = { fg = norm },
    htmlH3 = { fg = norm },
    htmlH4 = { fg = norm },
    htmlH5 = { fg = norm },
    htmlH6 = { fg = norm },
    htmlBold = { fg = norm },
    htmlItalic = { fg = norm },
    htmlEndTag = { fg = norm },
    htmlTag = { fg = norm },
    htmlTagName = { fg = norm },
    htmlArg = { fg = norm },
    htmlError = { fg = red },
    javaScript = { bg = bg, fg = norm },
    javaScriptBraces = { bg = bg, fg = norm },
    javaScriptNumber = { bg = bg, fg = green },
    diffRemoved = { link = "DiffDelete" },
    diffAdded = { link = "DiffAdd" },
    TSAnnotation = { link = "secondAccent" },
    TSAttribute = { link = "secondAccent" },
    TSBoolean = { link = "Constant" },
    TSCharacter = { link = "Constant" },
    TSComment = { link = "Comment" },
    TSConstructor = { link = "Normal" },
    TSConditional = { link = "Statement" },
    TSConstant = { link = "Constant" },
    TSConstBuiltin = { link = "secondAccent" },
    TSConstMacro = { link = "secondAccent" },
    TSError = { link = "Error" },
    TSException = { link = "Error" },
    TSField = { link = "Normal" },
    TSFloat = { link = "Constant" },
    TSFunction = { link = "Normal" },
    TSFuncBuiltin = { link = "secondAccent" },
    TSFuncMacro = { link = "secondAccent" },
    TSInclude = { link = "Noise" },
    TSKeyword = { link = "Statement" },
    TSKeywordFunction = { link = "Statement" },
    TSLabel = { link = "Noise" },
    TSMethod = { link = "Normal" },
    TSNamespace = { link = "Noise" },
    TSNone = { link = "Noise" },
    TSNumber = { link = "Constant" },
    TSOperator = { link = "Normal" },
    TSParameter = { link = "Noise" },
    TSParameterReference = { link = "Statement" },
    TSProperty = { link = "TSField" },
    TSPunctDelimiter = { link = "Noise" },
    TSPunctBracket = { link = "Noise" },
    TSPunctSpecial = { link = "Noise" },
    TSRepeat = { link = "Normal" },
    TSString = { link = "Constant" },
    TSStringRegex = { link = "secondAccent" },
    TSStringEscape = { link = "secondAccent" },
    TSTag = { link = "Statement" },
    TSTagDelimiter = { link = "Noise" },
    TSText = { link = "Normal" },
    TSEmphasis = { link = "Comment" },
    TSUnderline = { link = "Underlined" },
    TSStrike = { link = "Underlined" },
    TSTitle = { link = "Statement" },
    TSLiteral = { link = "Noise" },
    TSURI = { link = "Constant" },
    TSType = { link = "Noise" },
    TSTypeBuiltin = { link = "secondAccent" },
    TSVariable = { link = "Normal" },
    TSVariableBuiltin = { link = "Normal" },
    TSRepeat = { link = "Statement" },
    LspDiagnosticsDefaultError = { link = "Error" },
    LspDiagnosticsDefaultWarning = { link = "WarningMsg" },
    LspDiagnosticsDefaultInformation = { link = "Noise" },
    LspDiagnosticsDefaultHint = { link = "Constant" },
    SignifySignAdd = { link = "LineNr" },
    SignifySignDelete = { link = "LineNr" },
    SignifySignChange = { link = "LineNr" },
    GitGutterAdd = { link = "LineNr" },
    GitGutterDelete = { link = "LineNr" },
    GitGutterChange = { link = "LineNr" },
    GitGutterChangeDelete = { link = "LineNr" },
    jsFlowTypeKeyword = { link = "Statement" },
    jsFlowImportType = { link = "Statement" },
    jsFunction = { link = "Function" },
    jsGlobalObjects = { link = "Noise" },
    jsGlobalNodeObjects = { link = "Normal" },
    jsSwitchCase = { link = "Constant" },
    jsSpreadOperator = { bg = bg, fg = selection },
    jsReturn = { link = "jsSpreadOperator" },
    jsExport = { link = "jsSpreadOperator" },
    rustModPath = { fg = colors.lightest_gray },
    rustMacro = { link = "secondAccent" },
    rustKeyword = { link = "Noise" },
    rustDerive = { link = "secondAccent" },
    rustDeriveTrait = { link = "secondAccent" },
    rustAttribute = { link = "secondAccent" },
    rustLifetime = { link = "secondAccent" },
    schemeSyntax = { link = "Normal" },
    schemeParentheses = { link = "Noise" },
    schemeIdentifier = { link = "Noise" },
    lispParen = { link = "Noise" },
    lispSymbol = { link = "Noise" },
    shCommandSub = { link = "secondAccent" },
    cFormat = { link = "secondAccent" },
    nixBuiltin = { link = "secondAccent" },
    nixNamespacedBuiltin = { link = "secondAccent" },
    sqlSpecial = { link = "firstAccent" },
    sqlKeyword = { link = "secondAccent" },
    helpExample = { link = "Noise" },
    helpCommand = { link = "secondAccent" },
    helpBacktick = { link = "secondAccent" },
    helpSpecial = { link = "Noise" },
    StorageClass = { link = "Statement" },
    elmType = { link = "Type" },
    xmlTag = { link = "Constant" },
    xmlTagName = { link = "xmlTag" },
    xmlEndTag = { link = "xmlTag" },
    xmlAttrib = { link = "xmlTag" },
    markdownH1 = { link = "Statement" },
    markdownH2 = { link = "Statement" },
    markdownH3 = { link = "Statement" },
    markdownH4 = { link = "Statement" },
    markdownH5 = { link = "Statement" },
    markdownH6 = { link = "Statement" },
    markdownListMarker = { link = "Constant" },
    markdownCode = { link = "Constant" },
    markdownCodeBlock = { link = "Constant" },
    markdownCodeDelimiter = { link = "Constant" },
    markdownHeadingDelimiter = { link = "Constant" },
    cssBraces = { bg = bg, fg = selection },
    cssTextProp = { link = "Noise" },
    cssTagName = { link = "Normal" },
    NormalFloat = { link = "FloatWin" },
    CmpItemKind = { link = "firstAccent" },
    CmpItemAbbrMatch = { link = "secondAccent" },
}

if vim.fn.has("gui_running") == 0 then
    highlights.SpellBad = { cterm = "underline", fg = red }
    highlights.SpellCap = { cterm = "underline", fg = light_green }
    highlights.SpellRare = { cterm = "underline", fg = colors.pink }
    highlights.SpellLocal = { cterm = "underline", fg = green }
end

for group, opts in pairs(highlights) do
    if opts.link then
        vim.api.nvim_set_hl(0, group, { link = opts.link })
    else
        vim.api.nvim_set_hl(0, group, opts)
    end
end
