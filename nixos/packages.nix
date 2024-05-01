{ config, pkgs, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    gh
    neovim
    rustup
    discord
    steam
    alejandra
  ];
}
