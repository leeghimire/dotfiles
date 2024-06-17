{
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;

    # displayManager = {
    #   autoLogin.enable = true;
    #   autoLogin.user = "amper";
    #   lightdm.enable = true;
    # };

    layout = "us";
    xkbVariant = "";

    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad.accelProfile = "flat";
    };

    videoDrivers = [];
    deviceSection = ''Option "TearFree" "True"'';
    #displayManager.gdm.enable = true;
    #desktopManager.gnome.enable = true;
  };
}
