{
  description = "nixos flake";

  inputs = {
    # flake inputs 有很多种引用方式，应用最广泛的格式是:
    #     github:owner/name/reference
    # 即 github 仓库地址 + branch/commit-id/tag
    # NixOS 官方软件源，这里使用 nixos-unstable 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";
        # see https://nixos-cn.org/tutorials/installation/Networking.html
    
    # home-manager，用于管理用户配置
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    
    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      # "github:damien-biasotto/nixos-apple-silicon/bugfix/wifi"
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # chinese-fonts-overlay.url = "github:brsvh/chinese-fonts-overlays/main";
    
    niri.url = "github:sodiboo/niri-flake";
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    mkArgs = { inputs, system, ... }: {
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;# 这里递归引用了外部的 system 属性
        config.allowUnfree = true;
      };
      inherit inputs;
    };
  in {
    nixosConfigurations."nixVM" = nixpkgs.lib.nixosSystem rec {
    # hostname 为 nixos 的主机会使用这个配置
    # 这里使用了 nixpkgs.lib.nixosSystem 函数来构建配置，
    # 后面的 attributes set 是它的参数，在 nixos 系统上使用如下命令即可部署此配置：
    #     nixos-rebuild switch --flake .#nixos-test
      system = "aarch64-linux"; # pkgs.stdenv.hostPlatform.system;
      specialArgs = mkArgs { inherit inputs system; };
      modules = [
        ./machines/nixVM
        ./system
        ./hm
      ];
      # { _module.args = { inherit inputs; };}
      # modules end
    };
    
    nixosConfigurations."nixple" = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      specialArgs = mkArgs { inherit inputs system; };
      modules = [
        ./machines/apple-silicon
        ./system
        ./hm
      ];
    };
    nixosConfigurations."9700X" = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = mkArgs { inherit inputs system; };
      modules = [
        ./machines/9700X
        ./system
        ./hm
      ];
    };
    nixosConfigurations."garnixple" = nixpkgs.lib.nixosSystem rec {# almost Abandoned beacause experimentalGPUInstallMode Abandened
      system = "aarch64-linux";
      specialArgs = mkArgs { inherit inputs system; };
      modules = [
        ./machines/apple-silicon
        ./system
        ./hm
        ({ lib, ... }:{
          hardware.asahi.experimentalGPUInstallMode = lib.mkForce "driver";
          mine.machine.name = lib.mkForce "garnixple";
        })
      ];
    };
    # output end
  };
  
}
