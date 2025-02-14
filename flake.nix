# 💫 https://github.com/JaKooLit 💫 #
{
  description = "KooL's NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nvf.url = "github:notashelf/nvf";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    #hyprland.url = "github:hyprwm/Hyprland"; # hyprland development
    ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
    #distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes"; #for grub themes
  };

  outputs = inputs @ {
    self,
    nixpkgs,
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
        ];
      };
    };
  };
}
