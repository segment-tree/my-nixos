{inputs, pkgs, lib, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../../system
    ];
  #custom settings are here:
  mine.machine.name = "9700X";
  mine.machine.gaming-user.enable = true;
  
  services.keyd.keyboards.default = {
    extraConfig = ''
      [main]
      meta=layer(alt)
      leftalt=layer(meta)
    '';
  };
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
}
