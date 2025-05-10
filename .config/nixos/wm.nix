{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi-wayland
    flameshot
    wl-clipboard
    mako
    waybar

    gnome-keyring
    polkit_gnome
    networkmanagerapplet

    powertop
  ];

  services.gnome.gnome-keyring.enable = true;
  # auto-unlock the keyring at login
  # security.pam.services.g.enableGnomeKeyring = true;
  # needed for graphical sudo prompts, like nm-applet
  # security.pam.services.sudo.enableGnomeKeyring = true;

  services.tlp = {
    enable = true;
    settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
    };
  };

  powerManagement.powertop.enable = true;
  # systemd.services.powertop = {
  #   description = "Powertop tunings";
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.powertop}/bin/powertop --auto-tune
  #   };
  # };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
