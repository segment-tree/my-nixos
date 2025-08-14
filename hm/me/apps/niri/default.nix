{ pkgs, config, ... }:

{
  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/niri" = {
  #   source = ./dotfiles;
  #   recursive = true;   # 递归整个文件夹
  #   # executable = true;  # 将其中所有文件添加「执行」权限
  # };
  home.packages = with pkgs; [
    waybar
    swaylock
  ];
  home.file.".config/niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/hm/me/apps/niri/dotfiles/niri/config.kdl;
  home.file.".config/xdg-desktop-portal/niri-portals.conf".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/hm/me/apps/niri/dotfiles/xdg-desktop-portal/niri-portals.conf;
  home.file.".config/waybar/config".source =  config.lib.file.mkOutOfStoreSymlink /etc/nixos/hm/me/apps/niri/dotfiles/waybar/config;
  home.file.".config/waybar/style.css".source =  config.lib.file.mkOutOfStoreSymlink /etc/nixos/hm/me/apps/niri/dotfiles/waybar/style.css;
}
