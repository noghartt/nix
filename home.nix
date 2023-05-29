{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    coreutils
    curl
    wget
    htop
    cocoapods
    m-cli
    nodejs
  ];

  programs.zsh = {
    enable = true;
    initExtra = ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi

    # opam configuration
    [[ ! -r /Users/noghartt/.opam/opam-init/init.zsh ]] || source /Users/noghartt/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
    
    # enable homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    shellAliases   = {
      ls = "ls --color";
    };

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "v0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
            {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "command-not-found" ];
      theme = "robbyrussell";
    };
  };
}