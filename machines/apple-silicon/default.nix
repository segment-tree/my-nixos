{inputs, pkgs, lib, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      #./apple-silicon-support
      inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
      ./hardware-configuration.nix
      # ../../system
    ];
  #custom settings are here:
  mine.machine.name = "nixple";
  
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  ### cross compile
  boot.binfmt.emulatedSystems = [ "x86_64-linux" "i386-linux" ];
  
  hardware.asahi = {
    setupAsahiSound = true;
    peripheralFirmwareDirectory = ./firmware;
    withRust = true;
    useExperimentalGPUDriver = true;
  };
  hardware.graphics.enable = true;
  hardware.graphics.package = lib.mkForce pkgs.mesa-asahi-edge.drivers;###
  
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 12*1024;
  } ];
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.zpool=zsmalloc"
    "zswap.max_pool_percent=50"
  ];
  # zramSwap.enable = true;
  # see https://github.com/tpwrules/nixos-apple-silicon/issues/253  https://www.reddit.com/r/AsahiLinux/comments/1gy0t86/psa_transitioning_from_zramswap_to_zswap/
  
  services.keyd.keyboards.default = {
    extraConfig = ''
      [main]
      fn=layer(control)
      leftcontrol=layer(fn)
    '';
  };
}
