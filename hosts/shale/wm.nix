{ pkgs, ... }: {
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session = {
      user = "greeter";
      command = "${pkgs.greetd}/bin/agreety --cmd ${pkgs.niri}/bin/niri-session";
    };
  };
}
