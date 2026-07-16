{ pkgs, zen-browser, ... }:
let
  niriConfig = pkgs.runCommand "niri-config.kdl" { } ''
    cp ${pkgs.niri.doc}/share/doc/niri/default-config.kdl $out

    substituteInPlace $out \
      --replace-fail 'spawn-at-startup "waybar"' '// spawn-at-startup "waybar"' \
      --replace-fail 'Mod+T hotkey-overlay-title="Open a Terminal: alacritty" { spawn "alacritty"; }' 'Mod+T hotkey-overlay-title="Open a Terminal: ghostty" { spawn "ghostty"; }' \
      --replace-fail 'Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }' 'Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }' \
      --replace-fail 'gaps 16' 'gaps 0'

    cat >> $out <<'EXTRA'

debug {
    render-drm-device "/dev/dri/by-path/pci-0000:08:00.0-render"
}

output "Samsung Electric Company LC27RG50 H4ZN400635" {
    mode "1920x1080@239.760"
    position x=0 y=0
}

output "PNP(UGD) CD120FH 20210617" {
    mode "1920x1080@60.042"
    scale 1.25
    position x=192 y=1080
}

spawn-at-startup "swaybg" "-o" "DP-3" "-i" "/home/lee/Pictures/desktop.jpg" "-m" "fill"
spawn-at-startup "swaybg" "-o" "HDMI-A-3" "-i" "/home/lee/Pictures/tablet.jpg" "-m" "fill"

window-rule {
    draw-border-with-background false
    geometry-corner-radius 12
    clip-to-geometry true
}

window-rule {
    match app-id="mpv"
    match app-id="org.pwmt.zathura"
    match app-id="imv"
    match app-id="org.gnome.Nautilus"
    open-floating true
}
EXTRA
  '';
in {
  imports = [ zen-browser.homeModules.beta ];

  programs.zen-browser.enable = true;

  home.sessionVariables.NIXOS_OZONE_WL = "1";
  home.sessionVariables.GTK_THEME = "Colloid-Dark";

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  dconf.settings."org/gnome/desktop/wm/preferences"."button-layout" = ":";

  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3 = {
      extraConfig.gtk-decoration-layout = ":";
    };
    gtk4 = {
      theme = {
        name = "Colloid-Dark";
        package = pkgs.colloid-gtk-theme;
      };
      extraConfig.gtk-decoration-layout = ":";
    };
  };

  xdg.configFile."niri/config.kdl".source = niriConfig;

  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside your Wayland compositor";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };

  home.packages = with pkgs; [
    fuzzel
    grim
    swaybg
    wl-clipboard
    xclip
    xwayland-satellite

    adwaita-icon-theme
    blender
    codex
    ghostty
    imv
    krita
    mpv
    nautilus
    obsidian
    overskride
    zathura

    nodejs
    (python3.withPackages (ps: [ ps.huggingface-hub ps.hf-xet ]))
  ];
}
