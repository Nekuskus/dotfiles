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
    ./hardware.nix
  ];

  services.printing.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/mi/dotfiles/nixos/config.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  system.stateVersion = "23.11";
}
