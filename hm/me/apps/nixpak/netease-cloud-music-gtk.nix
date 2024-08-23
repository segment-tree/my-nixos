{ nixpakConf, pkgs, pkgs-stable, lib, osConfig, ... }:
with nixpakConf; {
  home.packages = [
    (pkgs.makeDesktopItem {
      name = "netease-cloud-music-gtk";
      desktopName = "Netease Cloud Music";
      exec = "netease-cloud-music-gtk4 %U";
      terminal = false;
      icon = "${pkgs.netease-cloud-music-gtk}/share/icons/hicolor/scalable/apps/com.gitee.gmg137.NeteaseCloudMusicGtk4.svg";
      type = "Application";
      categories = [ "AudioVideo" ];
      comment = "Netease Cloud Music boxed";
    })
    
    (mkPak {
      config = { sloth, ... }: {
        flatpak.appId = "com.gitee.gmg137.NeteaseCloudMusicGtk4";
        fonts.fonts = osConfig.fonts.packages;
        dbus.policies = {
          # "org.freedesktop.portal.Flatpak" = "talk";
          "org.freedesktop.portal.FileChooser" = "talk";
        };
        bubblewrap = {
          bind.rw = [
            (safebind  sloth "/share" "/.local/share")
            (safebind  sloth "/lyrics" "/.lyrics")
            (safebind' sloth "/config" sloth.xdgConfigHome)
            (sloth.concat' sloth.homeDir "/Music")
          ];
          sockets = {
            wayland = true;
            pipewire = true;
          };
          bind.dev = [
            "/dev/dri"
          ];
          tmpfs = [ "/tmp" ];
        };

        imports = [ gui' network' ];
        app = {
          package = pkgs.netease-cloud-music-gtk;
          binPath = "netease-cloud-music-gtk4";
        };
      };
    }).config.script
  ];
}


