{inputs, pkgs, lib, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      #./apple-silicon-support
      inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
      ./hardware-configuration.nix
      ../../system
    ];
  #custom settings are here:
  networking.hostName = "nixple";
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  hardware.asahi = {
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
  
  services.keyd = {
    enable = true;
    keyboards = {
      # The name is just the name of the configuration file, it does not really matter
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
        # Everything but the ID section:
        settings = {
          # The main layer, if you choose to declare it in Nix
          main = {};
          otherlayer = {};
      };
      extraConfig = ''
        [main]
        fn=layer(control)
        leftcontrol=layer(fn)
        capslock=layer(mylayer)
        [mylayer]
        h=left
        j=down
        k=up
        l=right
        space=M-S-space
      '';
    };
  };
};
}
