{ inputs, pkgs, lib, ... }:
let
  nixpakConf = {
    mkPak = inputs.nixpak.lib.nixpak {
      inherit pkgs;
      inherit (pkgs) lib;
    };
    gui' = ./gui-base.nix;
    network' = ./network-base.nix;
    safebind = sloth: realdir: mapdir: [
      (sloth.mkdir (sloth.concat' sloth.appDataDir realdir))
      (sloth.concat' sloth.homeDir mapdir)
    ];
    safebind' = sloth: realdir: mapdir': [
      (sloth.mkdir (sloth.concat' sloth.appDataDir realdir))
      mapdir'
    ];
  };
in {
  imports = [
    ./qq.nix
    ./bookworm.nix
    ./gnome-2048.nix
    ./netease-cloud-music-gtk.nix
    ./vscode.nix
  ];
  _module.args = { inherit nixpakConf; };
  home.packages = [
    (nixpakConf.mkPak {
      config = { sloth, ...}: {
        dbus.enable = false;
        bubblewrap = {
          bind.ro = [ sloth.homeDir ];
          network = false;
        };
        app.package = pkgs.hello;
      };
    }).config.script
  ];
}
