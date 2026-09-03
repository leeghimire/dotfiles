{ pkgs, ... }: {
  # Bare "origin" repos live in /media/hawaii/origin. The git user's login
  # shell is git-shell, so the keys below can run git-upload-pack /
  # git-receive-pack and nothing else — no interactive shell, no scp, no
  # commands. Safe to hand to machines that must never get a real shell.
  #
  # Because home is the origin dir, remote URLs are just:
  #   git@rhyolite:name.git      (scp syntax, needs a Host entry for port 69)
  #   ssh://git@<host>:69/~/name.git
  #
  # New bare repo: git init --bare --shared=group /media/hawaii/origin/name.git
  # (the setgid bit on origin/ makes it group "git" automatically)
  users.users.git = {
    isSystemUser = true;
    group = "git";
    home = "/media/hawaii/origin";
    createHome = false;
    shell = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAEAQDPLPSp9zH8hnYHSMjFS78cRtZUTkdJx5AVsfqHowsXgORC6YwnEpbDqvZtCPTFKJegIadizphiwFEn7TJ6KRKhZESYwmv9Iwb39Z+vbPEmOGgJqknhHZ8IBtxsOLoS89dgNy/+jhe6CQ34z+FEt+c0yEYr3T/UkqhbIMohs6cQ1LNOU0HhJyv1dAWztfqoenb3v5vl+rRXbPoV0VMczlh12lMmrKpjgv5/dg57lIu0TnC7bVWrNeBc9ImPGDZU96G/QdvTSINlDDnJ07FzPIrL4/0I5MXjNxKzdU4pjkjTwgjaO3Unhb4Oq2YcjTOyx1/2uFftXawW0nIMz+zn0Sfrw0sCbwbjpj7iF6dvoC6oBapaOWyaQ3DxBVTHd6slkiIbrJjOPKRseEM+GOqhlznEWACZF/9m9pdkp6mIPgULKgi0zA8VKxI1PxV+BKpk3reoZOFi8CH6bDge/Guh5J+Q9iGh2YZ8oXMEe+cB20otxKqfjvUFlKJvk2CeUHEYgdu/Ao1rcZ4tl6JniguRWxteW0zLHEIZ3QlBROW4E6WJC6JSDOrbYUZ40Q3Lt4nFkw63KKsxJ6rBQAm/E/92Bolpz6JGwXZeSG3K0d3pNL1jc2ckaWG8MaaT+IqwvkDp85viWEBopuewM6sfGQ2qOXyCCqkEiLnwmseo7+zKTRMoXhWKNwwVnaofXOxRQNrm5ZQIS838rFAy6R7fFoK12JXX/UVzSi4nP12TFg6T8EX3QFKR9/fxxEgaXL28pHYZCwG6z+1kiNf4cCHlvGocAv++YM0M6BvPUbOZRObStaz8hJEDknwKcGckAeF/syWUb7V+ju5bSluAq9J9izYm6emEHJrHXfRjDZCvDQt169xuZnA/nDIZjHMcck4MKaMI4jx62TqZXbcvWraZAmafzUv6brDn2xa9rLaRNaRViFcHV/Z8+OSFOfHUyfXQT66XRvSxZjPSFvvm1MtoZBR4HiBkRjk8UV6pSBuUkULeE1lt0y9OeWD6IVykHuLeWyiKH0oLx+SunP49Wj5CMFIe1G43/OzJtb6tfxa6jXLCjWnXt15Ht2mMP2tkFUCpEZnq3LHUJ/AXlKbVHC2vlOiVEZfchnpMm3kqMjFmzywGub1QMUSSEoe6rzg0i6Bg8kLhl3b4eEqbhELB/KuxsgKgJbOVhJ/XfeOPu9pfe+DA8SYLVpdYwhLMn8AcLQkhEkEoiX23YBumxxnYkUl1PKcUaKfcsqpxN1pOPmdmK+cvqxBTjC/NNujQortJ0oNA4DMoUwvFgzaUod5BFTDj1SaQHe70BndUdrOtTn9MipJBO15+1DTkOf8bRt8ADQaKt45x1H7SiMJ4wLkdKhPPpX8C+onh lee@Lees-MacBook-Air.local"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1bb48WAbicvEh2dZTGpMhdgK6c5AnoxQ2YdyQu5RhZQTHF+Dyhdfx/WIoHvGmHy5ellvtkwmbGINLJGrYgUUsAae50d0BpluzmPmdC1U+GACxd/I7AZ2oocHG6vMVGc9D/nuJKRIPjv43Fb/Zvl8N371q2bLkXXDhbnsRCjP4MiR6RDh3COzVIfSqrmEZMzo+xVXDPyDZwgXpW3Ex7rEyrg1G/e9hE2rBLZdOoybiL5vgddzbQhkfhjg8Et0vYjoMInZfsOMhrzDshLdvCAVfYc6m9LjNsY6WqLlf+QrxyWSKqhS4iUngch7H14Bpi/kWl0xaMBcU32bCU8eKRis7kjzuerAKEFhjXjS6hsShbPH670sZh8Otc5UXHPYvMtuDKa90rxfMH8ANnmvrcnm4MSCPStNQwzErTYj1EvDcQybcZ0gkMgXy9Ytj97QeXo3VKc9XL4LhxHqAwzxL4qc032aLVOVJWxY9zOkoAjV3Gh3kUQiXOoS/k+rTHMTs4RfqoD+Nm0E9FMZxq6677vxblHriNb6U+KDWU0n/9p8LNWqYt5AXtKTczjrTaAIVKJYDrzXtCfa9U3bBjpXAkja12rBvCjTSshGxyv+7o73Z7279BEVbwkokYWBw9AWtyR0FIKxhfiVPz++wjC2UCFP7Mi7EKoHLqJYoSskjT+sBUQ== lee@shale"
    ];
  };
  users.groups.git = { };

  # lee owns and administers the bare repos directly (group-writable repos).
  users.users.lee.extraGroups = [ "git" ];
}
