{ pkgs, ... }: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
}
