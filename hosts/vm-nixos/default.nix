{ ... }:
{
  imports = [
    ../../modules/common.nix
    ../../modules/ssh.nix
  ];

  system.stateVersion = "25.05";

  networking.hostName = "vm-nixos";

  home-manager.users.lee.programs.zen-browser.enable = false;
}
