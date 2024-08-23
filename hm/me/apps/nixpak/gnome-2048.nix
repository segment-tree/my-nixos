{ nixpakConf, pkgs, pkgs-stable, lib, osConfig, ... }:
{
  home.packages = lib.mkIf (!osConfig.mine.machine.isVM) [
    (pkgs.makeDesktopItem {
      name = "gnome-2048";
      desktopName = "gnome-2048";
      exec = "gnome-2048 %U";
      terminal = false;
      # icon = "gnome-2048";
      icon = "${pkgs.gnome-2048}/share/icons/hicolor/scalable/apps/org.gnome.TwentyFortyEight.svg";
      type = "Application";
      categories = [ "Game" ];
      comment = "gnome-2048 boxed";
    })
    
    (nixpakConf.mkPak {
      config = { sloth, ... }: {
        flatpak.appId = "org.gnome.TwentyFortyEight";
        bubblewrap = {
          network = false;
          bind.dev = [
            "/dev/dri"
          ];
          tmpfs = [ "/tmp" ];
        };

        imports = [ ./gui-base.nix ];
        app = {
          package = pkgs.gnome-2048;
          binPath = "gnome-2048";
        };
      };
    }).config.script
  ];
}
