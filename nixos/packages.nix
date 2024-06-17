{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = false;
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    chromium
    mpv

    st
    dmenu

    # Coding stuff
    gnumake
    gcc
    nodejs
    python

    # CLI utils
    wget
    git
    unzip
    ffmpeg
    zip
    ntfs3g
    brightnessctl
    swww

    # GUI utils
    feh
    dmenu

    # Xorg stuff
    xclip
    #xrandr?
    xorg.xbacklight

    # Sound
    pipewire
    pulseaudio
    pamixer
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
