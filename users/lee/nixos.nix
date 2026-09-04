{ pkgs, ... }: {
  programs.fish.enable = true;

  users.users.lee = {
    isNormalUser = true;
    description = "lee";
    extraGroups = [ "dialout" "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
}
