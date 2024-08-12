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
  # boot.kernelParams = [ "brcmfmac.feature_disable=0x82000" ]; #?
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  hardware.asahi = {
    setupAsahiSound = true;
    peripheralFirmwareDirectory = ./firmware;
    withRust = true;
    # addEdgeKernelConfig = true; # All edge kernel config options are now the default.
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
  };
  hardware.graphics.enable = true;
  hardware.graphics.package = lib.mkForce pkgs.mesa-asahi-edge.drivers;###
  
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8*1024;
  } ];
  
  services.keyd.keyboards.default = {
    extraConfig = ''
      [main]
      fn=layer(control)
      leftcontrol=layer(fn)
    '';
  };
}
