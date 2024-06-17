{
  disko.devices = {
    disk = {
      my-disk = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
		content = {
                  type = "luks";
                  name = "crypted";
                  extraOpenArgs = [ ];
                  settings = {
                    # echo -n "password" > /tmp/secret.key
                    keyFile = "/tmp/secret.key";
                    allowDiscards = true;
                  };
                  content = {
		    type = "filesystem";
		    format = "btrfs";
		    mountpoint = "/";
                  };
	        };
	      };
            };
          };
        };
      };
    };
  };
}
