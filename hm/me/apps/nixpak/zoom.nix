# ZOOM NOT SUPPORT ARM LINUX
{ nixpakConf, pkgs, pkgs-stable, lib, osConfig, ... }:
with nixpakConf; {
  home.packages = [
    (pkgs.makeDesktopItem {
      name = "zoom";
      desktopName = "zoom";
      exec = "zoom-us %U";
      terminal = false;
      icon = "none";#${pkgs.vscode}/share/pixmaps/vscode.png";
      type = "Application";
      categories = [ "Office" ];
      comment = "zoom meeting boxed";
    })
    
    (mkPak {
      config = { sloth, ... }: {
        flatpak.appId = "com.zoom.zoom";
        fonts.fonts = osConfig.fonts.packages;
        dbus.policies = {
          "org.freedesktop.portal.Flatpak" = "talk";
          "org.freedesktop.portal.FileChooser" = "talk";
        };
        bubblewrap = {
          bind.rw = [
            (safebind  sloth "/share" "/.local/share")
            (safebind' sloth "/config" sloth.xdgConfigHome)
          ];
          bind.ro = [
            "/etc/machine-id"
            "/etc/localtime"
            "/run/current-system/sw/"
            # "/etc/profiles/per-user"
            # "/etc/static/profiles/per-user/"
            # "/etc/passwd"
          ];
          sockets = {
            x11 = true;
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
          package = pkgs.zoom-us;
          binPath = "zoom-us";
        };
      };
    }).config.script
  ];
}


