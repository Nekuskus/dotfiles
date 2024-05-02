# Kuskus's NixOS dotfiles (`mi@mi-desktop`)

These configure NixOS, i3, and provide a utility and setup scripts that I use daily.

To install, run the `setup` script:
```bash
sudo bash <(curl -s https://raw.githubusercontent.com/Nekuskus/dotfiles/master/setup)
```

> [!WARNING]
> The script will override `/etc/nixos/` (avoids error-prone `$NIX_PATH` troubles) and other `/.config/` paths, particularly ones intended for `i3`.
> Consider backing them up before running, unless you have your own setup script that will undo these changes.
