{ config, pkgs, lib, nur, pkgs-stable, osConfig, ... }:

{
  home.username = "me";
  home.homeDirectory = "/home/me";
  
  imports = [
    # nur.modules.homeManager.default # do not need that, use nixosmodule nur.modules.nixos.default
    ./tools/vhome.nix
    ./tools/fhs.nix
    # ./tools/asahi-tools.nix
    # ./apps/bookworm.nix
    ./apps/telegram-desktop.nix
    # ./apps/qq.nix
    ./apps/nixpak/base.nix
    ./apps/valent-connect.nix
    ./apps/niri
    ./apps/rime
    ./apps/vscode-ssh.nix
    ./apps/ai-tools.nix
  ] ++ (lib.optionals osConfig.mine.machine.gaming-user.enable [./tools/disable-steam.nix]);
  
  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # git 相关配置
  # programs.git = {
  #   enable = true;
  #   userName = "Ryan Yin";
  #   userEmail = "xiaoyin_c@qq.com";
  # };

  home.sessionVariables = { # about wayland & niri
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = lib.mkForce "1"; # don't know if it would affect gnome.
  };

  # 通过 home.packages 安装一些常用的软件
  home.packages = with pkgs;[
    # vscode.fhs
    vscode
    (pkgs.writeShellScriptBin "code-way" ''
      code --ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3 $@
    '')
    # (vscode.fhs.override {
    #   commandLineArgs =
    #     "--ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3";
    # })
    libreoffice #
    fortune
    just
    clang
    gnumake
    # cpeditor
    # firefox-wayland
    /*
    (qq.override {
      commandLineArgs =
        "--ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3";
    })*/
    # qq
    elan
    util-linux
    libnotify
    net-tools pciutils usbutils
    localsend

    file-roller # after some versions, gnome remove file-roller for default installation

    distrobox
    
    kubectl
    kubernetes-helm

    tmux
  ];
  
  xdg.enable = true;
  
  dconf.settings = {
    "org/gnome/desktop/interface".scaling-factor = lib.hm.gvariant.mkUint32 2;
    "org/gnome/SessionManager".auto-save-session = true; # NOT WORK
    "org/gnome/desktop/interface".text-scaling-factor = 1.03125; # 1.0625;
    # DELETE: dconf reset -f  "/org/gnome/shell/extensions/gsconnect/"
    # MODIFY: gsettings set org.gnome.desktop.interface text-scaling-factor 1.1875
  };

  home.sessionVariables = { # about xdg dirs
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
    PYTHONPYCACHEPREFIX = "${config.xdg.cacheHome}/python";
    PYTHONUSERBASE = "${config.xdg.dataHome}/python";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CGDB_DIR = "${config.xdg.configHome}/cgdb";

    GOPATH = "${config.xdg.dataHome}/go";
    GOMODCACHE = "${config.xdg.cacheHome}/go/mod";
  };

  home.activation = {
    createCustomDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "${config.xdg.stateHome}/bash"
      mkdir -p "${config.xdg.dataHome}/gnupg"
    '';
  };

  programs.bash = {
    bashrcExtra = ''
      alias hsc='_hsc(){ ghc -no-keep-hi-files -no-keep-o-files "$@";}; _hsc'
      #^ is temp
    '';
    enable = true;
    enableCompletion = true;
    historyFile = "${config.xdg.stateHome}/bash/history";
  };
  
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_prompt_pwd_dir_length 0
    '';
  };
  
  programs.firefox = {
    enable = true;
    profiles.me = {
      id = 0;
      name = "me";
      settings = { # about:config
        "mousewheel.system_scroll_override.enabled" = false;
        "apz.gtk.kinetic_scroll.enabled" = false;
        "mousewheel.default.delta_multiplier_y" = 36;
        "mousewheel.default.delta_multiplier_x" = 80;
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons;[
        ublock-origin
        tampermonkey
        single-file
        zoom-page-we
      ];
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  systemd.user.services.clash-meta = { # or: services.mihomo.enable
    Unit.Description = "clash vpn service";
    Install = {
      WantedBy = [ "default.target" ];
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.clash-meta}/bin/clash-meta";
    };
  };

  systemd.user.services.ydotoold = lib.mkIf osConfig.mine.machine.asServer.enable {
    Unit.Description = "ydotoold";
    Install = {
      WantedBy = [ "default.target" ];
      After = [ ];
    };
    Service = {
      ExecStart = "${pkgs.ydotool}/bin/ydotoold";
    };
  };

  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
