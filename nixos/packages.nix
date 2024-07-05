{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    arandr
    bitwarden
    brightnessctl
    dmenu
    eza
    feh
    ffmpeg
    fishPlugins.hydro
    fishPlugins.z
    flameshot
    git
    mpv
    neovim
    networkmanagerapplet
    ntfs3g
    qutebrowser
    ripgrep
    tmux
    chromium
    unzip
    xclip
    xfce.thunar
    zathura
    zip

    (st.overrideAttrs (oldAttrs: rec {
      patches = [
        (pkgs.fetchpatch {
          url = "https://raw.githubusercontent.com/leeghimire/dotfiles/main/patches/st.diff";
          sha256 = "sha256-g4rS8DD6ln7RJD1scVCweWmjTVNyU7gGgiI1e8Xg694=";
        })
      ];
    }))

  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
  ];
}
