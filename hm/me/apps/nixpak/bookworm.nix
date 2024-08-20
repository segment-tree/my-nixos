{ nixpakConf, pkgs, pkgs-stable, lib, osConfig, ... }:
with nixpakConf; {
  home.packages = lib.mkIf (!osConfig.mine.machine.isVM) [
    (pkgs.makeDesktopItem {
      name = "Bookworm";
      desktopName = "Bookworm";
      exec = "com.github.babluboy.bookworm %F";
      terminal = false;
      # icon = "com.github.babluboy.bookworm";
      icon = "${pkgs.bookworm}/share/icons/hicolor/128x128/apps/com.github.babluboy.bookworm.svg";
      type = "Application";
      categories = [ "Office" ];
      comment = "Bookworm boxed";
    })
    
    (mkPak {
      config = { sloth, ... }: {
        flatpak.appId = "com.github.babluboy.bookworm";
        fonts.fonts = osConfig.fonts.packages;
        dbus.policies = {
          "org.freedesktop.portal.Documents" = "talk";
          "org.freedesktop.portal.Flatpak" = "talk";
          "org.freedesktop.portal.FileChooser" = "talk";
        };
        bubblewrap = {
          bind.rw = [
            (safebind sloth "/share" "/.local/share")
            [
              (sloth.mkdir (sloth.concat' sloth.appDataDir "/config"))
              sloth.xdgConfigHome
            ]
            (sloth.concat' sloth.homeDir "/Documents")
            "/run/opengl-driver/lib/dri/"
          ];
          bind.ro = [
            "/etc/machine-id"
            "/etc/localtime"
            "/run/current-system/sw/"
          ];
          network = false;
          bind.dev = [
            "/dev/dri"
          ];
          tmpfs = [ "/tmp" ];
        };

        imports = [ gui' ];
        app = {
          package = pkgs-stable.bookworm;
          binPath = "com.github.babluboy.bookworm";
        };
      };
    }).config.script
  ];
}
