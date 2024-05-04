{
  config,
  pkgs,
  ...
}: {
  users.users.mi = {
    isNormalUser = true;
    description = "mi";
    extraGroups = ["networkmanager" "wheel" "ntfsuser"];
    packages = with pkgs; [
      kate
      thunderbird
    ];
  };
}
