{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.openbox.enable = true;

  environment.systemPackages = with pkgs; [
    xorg.xinit
  ];
}
