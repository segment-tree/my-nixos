{ nixpakConf, pkgs, pkgs-stable, lib, osConfig, ... }:
with nixpakConf; {
  home.packages = [
    (pkgs.makeDesktopItem {
      name = "vscode";
      desktopName = "vscode";
      exec = "code %U";
      terminal = false;
      icon = "${pkgs.qq}/share/pixmaps/vscode.png";
      type = "Application";
      categories = [ "Office" ];
      comment = "Visual Studio Code boxed";
    })
    
    (mkPak {
      config = { sloth, ... }: {
        flatpak.appId = "com.visualstudio.code";
        fonts.fonts = osConfig.fonts.packages;
        dbus.policies = {
          "org.freedesktop.portal.Flatpak" = "talk";
          "org.freedesktop.portal.FileChooser" = "talk";
        };
        bubblewrap = {
          bind.rw = [
            (safebind  sloth "/share" "/.local/share")
            (safebind  sloth "/vscode" "/.vscode")
            (safebind' sloth "/config" sloth.xdgConfigHome)
            (sloth.concat' sloth.homeDir "/code")
            "/run/user/1000/doc" ##..
          ];
          bind.ro = [
            "/etc/machine-id"
            "/etc/localtime"
            "/run/current-system/sw/"
            # "/etc/profiles/per-user"
            # "/etc/static/profiles/per-user/"
            # "/etc/passwd"
            "/etc"
            (sloth.concat' sloth.homeDir "/.bashrc")
          ];
          sockets = {
            x11 = true; ###
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
          package = pkgs.vscode.fhs;
          binPath = "code";
          # extraEntrypoints = ["/lib/vscode/code"];
        };
      };
    }).config.script
  ];
}


