{ pkgs, ... }: {
  programs.niri.enable = true;

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
