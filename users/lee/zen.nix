{
  config,
  pkgs,
  zen-browser,
  ...
}:
{
  imports = [ zen-browser.homeModules.beta ];

  home.file.${
    if pkgs.stdenv.isDarwin then
      "${config.home.homeDirectory}/Library/Application Support/Zen/profiles.ini"
    else
      "${config.xdg.configHome}/zen/profiles.ini"
  }.force =
    true;

  programs.zen-browser = {
    enable = true;

    policies.ExtensionSettings = {
      "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
        default_area = "menupanel";
      };
      "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
        installation_mode = "force_installed";
        default_area = "menupanel";
      };
      "soundfixer@unrelenting.technology" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/soundfixer/latest.xpi";
        installation_mode = "force_installed";
        default_area = "menupanel";
      };
    };

    profiles.default = {
      name = "Default Profile";
      path = if pkgs.stdenv.isLinux then "ne2w68lw.Default Profile" else "default";

      mods = [ "f7c71d9a-bce2-420f-ae44-a64bd92975ab" ];

      search = {
        force = true;
        default = "google";
        privateDefault = "google";
      };

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
          opacity = 0.9;
          texture = 0.0;
        };
      };
    };
  };
}
