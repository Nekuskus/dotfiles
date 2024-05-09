{
  config,
  pkgs,
  ...
}: {
  users.users.mi = {
    isNormalUser = true;
    description = "mi";
    extraGroups = ["networkmanager" "wheel" "beep"];
    packages = with pkgs; [
      kate
      thunderbird
    ];
  };

  users.groups = {
    "beep" = {};
  };
}
