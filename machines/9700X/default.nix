{inputs, pkgs, lib, pkgs-3e3afe51, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../../system
      ./longan-nano-usbip.nix # temp
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

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;

  boot.kernelPackages= pkgs.linuxPackages_zen;
  boot.kernelModules = [ "nct6683" ];

  /*
  environment.etc."sensors.d/msi-b650.conf".text = ''
    # 屏蔽主板上没有接线的风扇接口
    chip "nct6687-*"
      ignore fan2
      ignore fan6
      ignore fan7
      ignore fan8
      ignore fan9
      ignore fan10
      
      # name fans
      label fan1 "CPU Fan"
      label fan3 "Chassis Fan 1"
      label fan4 "Chassis Fan 2"
      label fan5 "Chassis Fan 3"

    # 屏蔽显卡上不存在的第三个风扇
    chip "xe-pci-*"
      ignore fan3
      label fan1 "GPU Fan Left"
      label fan2 "GPU Fan Right"
  ''; # 如果修改了主板布局，请务必更新这个选项。
  */
  
  #temp:
  nixpkgs.overlays = [
    # (final: prev: { mesa = pkgs-3e3afe51.mesa; })
  ];


  # DNS
  # maybe temp
  networking.nameservers = lib.mkForce [
    "1.1.1.1"
    "8.8.8.8"
  ];
  networking.networkmanager.dns = "none";

  # ip route replace throw 10.0.0.0/8 table 52
}
