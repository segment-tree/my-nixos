{ config, pkgs, ... }:

{
  # 1. 开启 Sunshine 服务
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # 允许抓取屏幕
    openFirewall = true; # 自动开启必要的端口 (47984-48010)
  };

  # 2. 必须开启 PipeWire（Wayland 抓屏核心）
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}