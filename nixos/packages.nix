{
  config,
  pkgs,
  ...
}: {
  programs.firefox.enable = true;
  programs.java.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {withJava = true;};
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Utils
    wget
    curl
    neovim
    git
    gh
    htop
    lspci
    wineWowPackages.stable

    # Toolchains
    rustup

    # Usermode applications
    discord
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
