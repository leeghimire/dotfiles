{ pkgs, ... }: {
  services.xserver.enable = false;
  services.xserver.displayManager.startx.enable = false;
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.windowManager.i3.enable = false;

  services.displayManager.autoLogin.enable = false;
  services.displayManager.defaultSession = null;

  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session = {
      user = "greeter";
      command = "${pkgs.greetd}/bin/agreety --cmd ${pkgs.niri}/bin/niri-session";
    };
  };
}
