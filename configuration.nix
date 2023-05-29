{ pkgs, lib, ... }:

{
  nix.settings = {
    trusted-users = [ "@admin" "noghartt" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    substituters = [ "https://cache.nixos.org" ];
  };

  nix.configureBuildUsers = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  homebrew = {
    enable = true;
    onActivation.autoUpdate = false; 
  };

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

  users.users.noghartt = {
    name = "noghartt";
    home = "/Users/noghartt";
  };
}