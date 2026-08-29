# Using the dotfiles
The setup assumes that some packages are installed on the system, the main one being `hyprland`, `kitty`, `fish`, `greetd`, `nvim`, `noctalia` and `noctalia-greeter`.
For a complete list refer to [packages](#packages)

## The manual way
If you want to manually configure the dotfiles, then copy the content of `dotfiles/fish`, `dotfiles/hypr`, `dotfiles/kitty`, `dotfiles/noctalia`, `dotfiles/nvim` and `dotfiles/zathura` to the corresponding directories in `~/.configs`, copy `dotfiles/wallpapers` to `~/Pictures`.

## The easy way (suggested)
Simply run the provided script file.

### About the mime directory
It contains a couple of custom `.desktop` files to handle some applications (imv, nvim and zathura), 
as well as a `mimeapps.list` to manage defaults.

## Packages
The packages used by the configuration can be divided into two main types: required and optional.

The required packages are:
- `adw-gtk-theme`
- `bat`
- `brother-dcp-l2510d`
- `fish`
- `gimp`
- `greetd`
- `gvfs`
- `gvfs-mtp`
- `hyprland`
- `hyprpolkitagent`
- `imv`
- `keychain`
- `kitty`
- `libxcrypt-compat`
- `localsend-bin`
- `mpv`
- `neovim`
- `nwg-look`
- `noctalia`
- `noctalia-greeter`
- `papirus-icon-theme`
- `telegram-desktop`
- `thunar`
- `thunar-volman`
- `timeshift`
- `tree-sitter-cli`
- `ttf-lilex-nerd`
- `tumbler`
- `wl-clipboard`
- `xdg-desktop-portal-hyprland`
- `yazi`
- `zathura`
- `zathura-pdf-poppler`
- `zen-browser-bin`

The optional packages are:
- `spotify`
- `spicitify-cli`
- `steam`
- `texlive`
