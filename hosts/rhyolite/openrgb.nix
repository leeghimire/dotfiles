{
  hardware.i2c.enable = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    startupProfile = "off.orp";
  };
}
