{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  # Proton/Steam requires 32-bit graphics support.
  # hardware.graphics.enable is set in modules/nvidia.nix.
  hardware.graphics.enable32Bit = true;

  environment.systemPackages = with pkgs; [
    discord
    prismlauncher
  ];
}
