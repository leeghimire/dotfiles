{ ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "lee";
  services.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3.enable = true;
  services.libinput.enable = true;
  services.libinput.mouse.middleEmulation = false;
}
