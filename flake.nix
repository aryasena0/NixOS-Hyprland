# 💫 https://github.com/JaKooLit 💫 #
{
  description = "KooL's NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nvf.url = "github:notashelf/nvf";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    #hyprland.url = "github:hyprwm/Hyprland"; # hyprland development
    ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
    #distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes"; #for grub themes
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    # nvf,
    ...
  }: let
    system = "x86_64-linux";
    host = "lalalainix";
    username = "aryasenap";

    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
  in {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit host;
        };
        modules = [
          ./hosts/${host}/config.nix
          # nvf.nixosModules.default
          #inputs.distro-grub-themes.nixosModules.${system}.default #for grub themes
        home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit inputs;
                inherit host;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = import ./hosts/${host}/home.nix;
            }
          ];
        ];
      };
    };
  };
}
