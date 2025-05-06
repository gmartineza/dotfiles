{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi-wayland
    waybar
    flameshot
    wl-clipboard
    mako
  ];

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

}
