{ pkgs, ... }: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    foliate
    ghostty
    mpv
    ungoogled-chromium
    wl-clipboard
  ];

  security.rtkit.enable = true;

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
}
