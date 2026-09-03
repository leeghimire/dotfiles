{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    discord
    prismlauncher
  ];
}
