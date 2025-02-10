# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only
{
  pkgs,
  username,
  ...
}: let
  inherit (import ./variables.nix) gitUsername;
in {
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
      ];

      # define user packages here
      packages = with pkgs; [telegram-desktop obs-studio bottles zed-editor ghq gh lazygit yazi];
    };

    defaultUserShell = pkgs.fish;
  };

  environment.shells = with pkgs; [fish];
  environment.systemPackages = with pkgs; [fzf zoxide];

  programs = {
    # Zsh configuration
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   ohMyZsh = {
    #     enable = true;
    #     plugins = ["git"];
    #     theme = "funky";
    #   };
    #
    #   autosuggestions.enable = true;
    #   syntaxHighlighting.enable = true;
    #
    #   shellAliases = {
    #             vim = "nix run github:notashelf/nvf#maximal";
    #         };
    #
    #   promptInit = ''
    #     fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
    #
    #     #pokemon colorscripts like. Make sure to install krabby package
    #     #krabby random --no-mega --no-gmax --no-regional --no-title -s;
    #
    #     source <(fzf --zsh);
    #     HISTFILE=~/.zsh_history;
    #     HISTSIZE=10000;
    #     SAVEHIST=10000;
    #     setopt appendhistory;
    #   '';
    # };
    fish = {
      enable = true;
      shellInit = ''
        export PNPM_HOME="/home/aryasenap/.local/share/pnpm"
        export PATH="$PNPM_HOME:$PATH"
      '';
      interactiveShellInit = ''
        zoxide init fish | source
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
      '';
      shellAliases = {
        vim = "nix run github:notashelf/nvf#maximal";
        svim = "sudo vim";
        fr = "nh os switch --hostname lalalainix /home/${username}/NixOS-Hyprland";
        fu = "nh os switch --hostname lalalainix --update /home/${username}/NiXOS-Hyprland";
        zu = "sh <(curl -L https://gitlab.com/aryasena0/NixOS-Hyprland/-/raw/main/install.sh)";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        cat = "bat";
        ls = "eza --icons";
        ll = "eza -lh --icons --grid --group-directories-first";
        la = "eza -lah --icons --grid --group-directories-first";
        l = "la";
        md = "mkdir -p";
        cd = "z";
        ".." = "cd ..";
      };
      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fishPlugins.plugin-git.src;
        }
      ];
    };
  };
}
