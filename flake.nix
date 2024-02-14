{
  description = "nixos flake";

  inputs = {
    # flake inputs 有很多种引用方式，应用最广泛的格式是:
    #     github:owner/name/reference
    # 即 github 仓库地址 + branch/commit-id/tag
    # NixOS 官方软件源，这里使用 nixos-unstable 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager，用于管理用户配置
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };
  
  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
    # hostname 为 nixos 的主机会使用这个配置
    # 这里使用了 nixpkgs.lib.nixosSystem 函数来构建配置，
    # 后面的 attributes set 是它的参数，在 nixos 系统上使用如下命令即可部署此配置：
    #     nixos-rebuild switch --flake .#nixos-test
      system = "aarch64-linux"; # pkgs.stdenv.hostPlatform.system;
      specialArgs = inputs;  # 将 inputs 中的参数传入所有子模块
      modules = [
        ./configuration.nix
        # nur.nixosModules.nur
        # { nixpkgs.overlays = [ nur.overlay ]; }
        home-manager.nixosModules.home-manager{
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # home-manager.users.me = import ./hm/me/home.nix;
          home-manager.users.me.imports = [ ./hm/me/home.nix ];
          home-manager.users.me._module.args = { inherit nur; };
          
          home-manager.users.gdm = { lib, ... }: {
            dconf.settings."org/gnome/desktop/interface".scaling-factor = lib.hm.gvariant.mkUint32 2;
            home.stateVersion = "23.05";
            programs.home-manager.enable = true;
          };
          # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
          # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
          home-manager.extraSpecialArgs = inputs;
        }
      ];
      # modules end
    };
  };
  
}
