# refer https://github.com/pokon548/OysterOS/tree/main/desktop/application/qq
{ nixpakConf, pkgs, lib, osConfig, ... }:
{
  home.packages = [
    (pkgs.makeDesktopItem {
      name = "qq";
      desktopName = "QQ";
      exec = "qq %U";
      terminal = false;
      # icon = "qq";
      icon = "${pkgs.qq}/share/icons/hicolor/512x512/apps/qq.png";
      type = "Application";
      categories = [ "Network" ];
      comment = "QQ boxed";
    })
    
    (nixpakConf.mkPak {
      config = { sloth, ... }: {
        flatpak.appId = "com.tencent.qq";
        fonts.fonts = osConfig.fonts.packages;
        dbus.policies = {
          "org.gnome.Shell.Screencast" = "talk";
          "org.freedesktop.Notifications" = "talk";
          "org.kde.StatusNotifierWatcher" = "talk";

          "org.freedesktop.portal.Documents" = "talk";
          "org.freedesktop.portal.Flatpak" = "talk";
          "org.freedesktop.portal.FileChooser" = "talk";
          
          "org.freedesktop.portal.IBus" = "talk";
          "org.freedesktop.IBus.Portal" = "talk";
          # "org.freedesktop.Sdk" = "talk";
        };
        
        bubblewrap = {
          bind.rw = [
            [
              (sloth.mkdir (sloth.concat [ sloth.appDataDir "/QQ" ]))
              (sloth.concat [ sloth.xdgConfigHome "/QQ" ])
            ]
            (sloth.mkdir (sloth.concat [ sloth.xdgDownloadDir "/QQ" ]))
            "/run/opengl-driver/lib/dri/"
          ];
          bind.ro = [
            "/etc/machine-id"
            "/etc/localtime"
            # [
            #   "${pkgs.xdg-utils}/bin/xdg-open"
            #   (sloth.concat' sloth.homeDir "/.local/bin/xdg-open")
            # ]# seems not work at all
          ];
          network = true;
          sockets = {
            x11 = true;
            wayland = true;
            pipewire = true;
          };
          bind.dev = [
            "/dev/dri"
            "/dev/shm"
            "/run/dbus"
          ];
          tmpfs = [ "/tmp" ];
          env = {
            IBUS_USE_PORTAL = "1";
          };
        
        };

        imports = [ ./gui-base.nix ];
        app = {
          package = pkgs.qq;
          binPath = "bin/qq";
        };
      };
    }).config.script
  ];
}
