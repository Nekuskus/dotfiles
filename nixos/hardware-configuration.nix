{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd" "pcspkr"];
  boot.extraModulePackages = [];

  nixpkgs.overlays = [
    (
      self: super: {
        # Enable pcspkr by uncommenting a line in /etc/modprobe.d/uubuntu.conf:blacklist.conf
        kmod-blacklist-ubuntu = super.kmod-blacklist-ubuntu.overrideAttrs (old: {
          fixupPhase = ''
            substituteInPlace "$out"/modprobe.conf \
            --replace "blacklist pcspkr" "# blacklist pcspkr"
          '';
        });
      }
    )
  ];

  services.udev.extraRules = ''
    # Add write access to the PC speaker for the "beep" group
    ACTION=="add", SUBSYSTEM=="input", ATTRS{name}=="PC Speaker", ENV{DEVNAME}!="", RUN+="${pkgs.acl}/bin/setfacl -m g:beep:w '$env{DEVNAME}'"
  '';

  #   probably unnecessary
  #   boot.supportedFilesystems = ["ntfs"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #   systemd = {
  #     targets = {
  #       sleep = {
  #         enable = false;
  #         unitConfig.DefaultDependencies = "no";
  #       };
  #       suspend = {
  #         enable = false;
  #         unitConfig.DefaultDependencies = "no";
  #       };
  #       hibernate = {
  #         enable = false;
  #         unitConfig.DefaultDependencies = "no";
  #       };
  #       "hybrid-sleep" = {
  #         enable = false;
  #         unitConfig.DefaultDependencies = "no";
  #       };
  #     };
  #   };
  #
  #   systemd.sleep.extraConfig = ''
  #     AllowSuspend=no
  #     AllowHibernation=no
  #     AllowHybridSleep=no
  #     AllowSuspendThenHibernate=no
  #   '';

  #   Not using grub, Window's on a separate drive so it'd only support chain loading, and I'd rather just mash F12 at boot
  #   boot.loader.grub.enable = lib.mkForce true;
  #   boot.loader.grub.gfxmodeEfi = "2560x1440x10";
  #   boot.loader.grub.device = "nodev";
  #   boot.loader.grub.useOSProber = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cf528388-0c14-46b3-8903-9b5be336cff3";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BB46-7200";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/26c95b40-1d60-4a07-8274-1827ed3274dc";
    fsType = "ext4";
  };

  fileSystems."/C" = {
    device = "/dev/disk/by-uuid/A6DC741EDC73E6C9";
    fsType = "ntfs-3g";
    options = ["rw"];
  };

  fileSystems."/D" = {
    device = "/dev/disk/by-uuid/7876885D76881E4E";
    fsType = "ntfs-3g";
    options = ["rw"];
  };

  fileSystems."/E" = {
    device = "/dev/disk/by-uuid/304020A74020762E";
    fsType = "ntfs-3g";
    options = ["rw"];
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/1FD7DBD054399698";
    fsType = "ntfs-3g";
    options = ["rw"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.

    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  powerManagement.enable = false;
  powerManagement.cpuFreqGovernor = "performance"; # maybe unnecessary? we'll see

  services.printing.enable = true;
}
