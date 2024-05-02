{
  config,
  pkgs,
  ...
}: {
  users.users.mi = {
    isNormalUser = true;
    description = "mi";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      kate
      thunderbird
    ];
  };
}
