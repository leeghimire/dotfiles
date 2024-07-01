{ pkgs, ... }: {
  # the whole idea of this module is terrible and should be done diffrently
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      /*not a de but idc*/
      windowManager.dwm.enable = true;
    };
    displayManager = {
      defaultSession = "none+dwm";
      autoLogin = {
          enable = true;
          user = "lee";
      };
    };
    libinput = {
      enable = true;
      touchpad.tapping = false;
      mouse.accelProfile = "flat";
      touchpad.accelProfile = "flat";
    };
  };
  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    patches = [
      (pkgs.fetchpatch {
        url = "https://raw.githubusercontent.com/leeghimire/dotfiles/main/patches/dwm.diff";
        hash = "sha256-Tt0k6koUn26HmkJ+7leSJ/HM+Pn/Ljq67RFfBtpelEg=";
      })
    ];
  };
}
