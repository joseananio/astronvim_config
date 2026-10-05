# AstroNvim Setup

A user configuration template for [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Back up any existing config, then clone this repository as your nvim config

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
git clone https://github.com/joseananio/astronvim_config ~/.config/nvim
```

Start nvim and let Lazy install everything

```shell
nvim
:Lazy
```

> Treesitter, Mason Tools and Lazy should all run to install packages

### Customization

Everything can be modified in the plugins, community.lua and polish.lua directory

- Package-specific mappings -> plugins/user.package definitions
- General mappings -> plugins/astrocore.lua
- LSP-specific mappings -> plugins/astrolsp.lua
