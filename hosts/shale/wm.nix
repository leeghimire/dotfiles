{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.getty.autologinUser = "lee";

  programs.bash.loginShellInit = ''
    if [ -z "$DISPLAY" ] && [ "''${XDG_VTNR:-0}" -eq 1 ]; then
      exec startx
    fi
  '';
  services.libinput.enable = true;
  services.libinput.mouse.middleEmulation = false;

  environment.systemPackages = with pkgs; [ xinit ];
}
