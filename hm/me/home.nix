{ config, pkgs, lib, nur, ... }:

{
  home.username = "me";
  home.homeDirectory = "/home/me";
  
  imports = [
    ./tools/vhome.nix
    ./tools/fhs.nix
    ./apps/bookworm.nix
    ./apps/telegram-desktop.nix
    ./apps/qq.nix
    nur.hmModules.nur
  ];
  
  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

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

  # 通过 home.packages 安装一些常用的软件
  home.packages = with pkgs;[
    fortune
    just
    # cpeditor
    # firefox-wayland
  ];
  
  dconf.settings = {
    "org/gnome/desktop/interface".scaling-factor = lib.hm.gvariant.mkUint32 2;
    "org/gnome/SessionManager".auto-save-session = true; # NOT WORK
    "org/gnome/desktop/interface".text-scaling-factor = 1.1875;
  };
  
  programs.bash = {
    bashrcExtra = "#test";
    enable = true;
    enableCompletion = true;
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
      extensions = with config.nur.repos.rycee.firefox-addons;[
        ublock-origin
        tampermonkey
      ];
    };
  };
  
  systemd.user.services.clash-meta = {
    Unit.Description = "clash vpn service";
    Install = {
      WantedBy = [ "default.target" ];
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.clash-meta}/bin/clash-meta";
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
