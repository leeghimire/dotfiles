{ pkgs, ... }: {
  programs.niri.enable = true;

  # Expose the AT-SPI accessibility bus to the graphical session so semantic
  # automation and assistive technologies can inspect Niri applications.
  services.gnome.at-spi2-core.enable = true;

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session = {
      user = "greeter";
      command = "${pkgs.greetd}/bin/agreety --cmd ${pkgs.niri}/bin/niri-session";
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  services.gvfs.enable = true;
}
