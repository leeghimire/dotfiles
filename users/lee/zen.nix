{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = lib.mkDefault true;

    # macOS installs Zen as a Homebrew cask, so the HM module only manages it.
    package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin null;

    policies = {
      SearchEngines.Default = "Google";

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "menupanel";
        };
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "menupanel";
        };
        "soundfixer@unrelenting.technology" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/soundfixer/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "menupanel";
        };
      };
    };

    profiles.default = {
      name = "Default Profile";
      mods = [ "f7c71d9a-bce2-420f-ae44-a64bd92975ab" ];
      spacesForce = true;
      spaces.Main = {
        id = "f3313bdb-b2bd-4fb4-935a-c7efffca523e";
        icon = "🍁";
        theme = {
          type = "gradient";
          colors = [
            {
              red = 240;
              green = 139;
              blue = 117;
              lightness = 70;
              position = {
                x = 218;
                y = 187;
              };
              type = "explicit-lightness";
            }
          ];
          opacity = 1.0;
          texture = 0.0;
        };
      };
    };
  };
}
