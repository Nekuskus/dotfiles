{config, ...}: {
  networking.hostName = "mi-desktop";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [5173];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  services.xrdp.openFirewall = true;

  systemd.user.services.tailscaleCert = {
    description = "...";
    script = ''
      sudo tailscale cert $(hostname).ts.net
    '';
    wantedBy = ["multi-user.target"]; # starts at boot
  };

  systemd.user.services.sunshineUdev = {
    description = "...";
    script = ''
      sudo chown mi:users /dev/uinput
    '';
    wantedBy = ["multi-user.target"]; # starts at boot
  };
}
