{ ... }:
{
  nix.settings = {
    allowed-users = [ "lee" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
