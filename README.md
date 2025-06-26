# AstroNvim Setup

A user configuration template for [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Clone this repository and cd into it

```shell
git clone <repo> && cd dir
```

#### Make a backup of your current nvim and shared folder and clone a new AstroNvim

```shell
./scripts/atronvim_manager.sh reinstall
```

Quit nvim and rerun

- Ensure the `lazy_setup.lua` imports `lua/user/plugins`, else add it

```lua
  { import = "user/plugins" },
```

and in nvim/init.lua, at the end

```lua
require "user"
```

```shell
nvim
:Lazy
```

> Treesitter, Mason Tools and Lazy should all run to install packages

### Customization

Everything can be modified in the user directory

- All packages are in the user/plugins/packages.lua
- Keybindings are in the mappings file
- Lsp-config contains extra configurations for the packages
