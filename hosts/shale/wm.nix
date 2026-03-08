{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.getty.autologinUser = "lee";

  environment.systemPackages = with pkgs; [ xinit ];
}
