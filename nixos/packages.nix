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
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-custom
    ];
  };
  #   chaotic.proton-ge-custom.enable = true;

  services.tailscale.enable = true;
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
    settings.X11Forwarding = true;
    settings.X11DisplayOffset = 10;
    settings.X11UseLocalhost = false;
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
    alejandra

    hyfetch
    neofetch
    fastfetch

    # System config
    acl

    # Toolchains
    rustup
    python3
    python311Packages.pip
    nodejs

    # Usermode applications
    discord
    vscode

    # Sway-specific
    grim # screenshot functionality, might switch to gnome scrot
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    rofi

    # chaotic's nyxpackages
    proton-ge-custom

    # unsorted / cuda
    gitRepo
    gnupg
    autoconf
    procps
    gnumake
    util-linux
    m4
    gperf
    unzip
    cudatoolkit
    linuxPackages.nvidia_x11
    libGLU
    libGL
    xorg.libXi
    xorg.libXmu
    freeglut
    xorg.libXext
    xorg.libX11
    xorg.libXv
    xorg.libXrandr
    xorg.xauth
    zlib
    ncurses5
    stdenv.cc
    binutils
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];
}
