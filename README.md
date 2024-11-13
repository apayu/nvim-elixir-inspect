# nvim-elixir-inspect

A Neovim plugin that helps you debug Elixir code by quickly inserting `IO.inspect/2` statements with the current function name as label.

## Features

- Quickly insert `IO.inspect` statements with customizable prefix symbol
- Automatically detects and uses current function name as label
- Maintains proper indentation

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "apayu/nvim-elixir-inspect",
  config = function()
    require("elixir-inspect").setup()
  end,
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  "apayu/nvim-elixir-inspect",
  config = function()
    require("elixir-inspect").setup()
  end
}
```

## Configuration

The plugin comes with these defaults:

```lua
require("elixir-inspect").setup({
  -- Symbol prefix for IO.inspect output
  symbol = "🔍 >>>>>>>",
  -- Default insert mode keymap
  keymap_insert = "<C-e>i"
})
```

## Usage

### Via Command

Use the `:InsertIOInspect` command to insert an IO.inspect statement at the current cursor position.

### Via Keymap

In insert mode, press `<C-e>i` (or your configured keymap) to insert an IO.inspect statement.

### Example Output

If you're in a function named `process_data`, the plugin will insert:

```elixir
IO.inspect("🔍 >>>>>>>", label: "process_data")
```

The inserted statement will maintain the current line's indentation.

## Customization

You can customize the plugin behavior by passing options to the setup function:

```lua
require("elixir-inspect").setup({
  -- Change the inspect prefix symbol
  symbol = "DEBUG >>>",
  -- Change or disable the insert mode keymap
  keymap_insert = "<C-x>i", -- or set to false to disable
})
```
