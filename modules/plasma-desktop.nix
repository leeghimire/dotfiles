{ pkgs, ... }: {
  services.desktopManager.plasma6.enable = true;

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Expose the AT-SPI accessibility bus to the graphical session so semantic
  # automation and assistive technologies can inspect applications.
  services.gnome.at-spi2-core.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
}
