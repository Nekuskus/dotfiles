{
  config,
  pkgs,
  ...
}: {
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    # Utils
    wget
    curl
    neovim
    git
    gh

    # Toolchains
    rustup

    # Usermode applications
    discord
    steam
    alejandra
    hyfetch
    neofetch
    fastfetch

    # Sway-specific
    grim # screenshot functionality, might switch to gnome scrot
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    rofi
  ];
}
