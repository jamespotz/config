local status_ok, lspkind = pcall(require, "lspkind")
if not status_ok then
	return
end

lspkind.init({
  -- Defines how annotations are shown,
  -- can be 'text', 'text_symbol', 'symbol' or 'symbol_text'
  -- default: symbol_text
  mode = 'symbol_text',

  -- Symbols list can be a preset or a table with custom icons
  -- 'default' and 'mdi' (requires nerd-fonts font) or
  -- 'codicons' (requires vscode-codicons font)
  -- No need to worry about the order as this is managed by the plugin
  -- default: 'default'
  -- or override preset symbols
  symbols = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '漣',
    Field = '',
    Variable = '',
    Class = 'פּ',
    Interface = '囹',
    Module = '',
    Property = '襁',
    Unit = '',
    Value = '',
    Enum = '惡',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '惡',
    Constant = '',
    Struct = 'ﴯ',
    Event = '',
    Operator = '',
    TypeParameter = '',
    Namespace = '異',
    Package = '',
    String = '',
    Number = '',
    Boolean = '蘒',
    Array = '',
    Object = '',
    Key = '',
    Null = 'ﳠ',
  }
})
