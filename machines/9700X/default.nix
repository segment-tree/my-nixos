{inputs, pkgs, lib, pkgs-3e3afe51, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../../system
    ];
  #custom settings are here:
  mine.machine.name = "9700X";
  mine.machine.gaming-user.enable = true;
  mine.machine.asServer.enable = true;
  
  services.keyd.keyboards.default = {
    extraConfig = ''
      [main]
      meta=layer(alt)
      leftalt=layer(meta)
    '';
  };
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";

  boot.kernelPackages= pkgs.linuxPackages_zen;
  #temp:
  nixpkgs.overlays = [
    # (final: prev: { mesa = pkgs-3e3afe51.mesa; })
  ];
}
