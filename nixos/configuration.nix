{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./locale.nix
    ./networking.nix
    ./display.nix
    ./audio.nix
    ./users.nix
    ./fonts.nix
    ./packages.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/mi/dotfiles/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # CUDA setup
  environment.variables = {
    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
    #     LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib;
  };

  system.stateVersion = "23.11";
}
