{ pkgs, config, ... }:

{
  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  home.file.".config/ibus/rime" = {
    source = ./dotfiles;
    recursive = true;   # 递归整个文件夹
    executable = true;  # 将其中所有文件添加「执行」权限
  };
  home.file.".local/share/fcitx5/rime" = {
    source = ./dotfiles;
    recursive = true;   # 递归整个文件夹
    executable = true;  # 将其中所有文件添加「执行」权限
  };
}
