{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 42069 ];
    settings = {
      AllowUsers = [ "lee" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.lee.openssh.authorizedKeys.keyFiles = [ ../users/lee/lee.pub ];
}
