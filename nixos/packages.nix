{
  config,
  pkgs,
  chaotic
  ...
}: {
  programs.firefox.enable = true;
  programs.java.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  chaotic.proton-ge-custom.enable = true;

  services.tailscale.enable = true;
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };
  users.users."mi".openssh.authorizedKeys.keyFiles = [
    /home/mi/.ssh/authorized_keys
  ];

  environment.systemPackages = with pkgs; [
    # Utils
    wget
    curl
    neovim
    git
    gh
    htop
    pciutils
    winetricks
    wineWowPackages.stable
    psmisc # killall, ...
    beep
    nmap-unfree

    # System config
    acl

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
