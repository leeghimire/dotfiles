{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      ls = "eza";
    };
  }; 
  users.users.lee = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
    packages = with pkgs; [
    ];
  };
}
