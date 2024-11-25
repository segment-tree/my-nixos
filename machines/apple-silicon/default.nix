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
  
  # boot.kernelParams = [ "brcmfmac.feature_disable=0x82000" ]; # fix wifi
  # see https://social.treehouse.systems/@AsahiLinux/112909897657710314 & https://github.com/tpwrules/nixos-apple-silicon/issues/225 # it should be fixed now
  
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
    size = 12*1024;
  } ];
  zramSwap.enable = true;
  
  services.keyd.keyboards.default = {
    extraConfig = ''
      [main]
      fn=layer(control)
      leftcontrol=layer(fn)
    '';
  };
}
