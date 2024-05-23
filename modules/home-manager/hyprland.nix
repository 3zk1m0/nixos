{ pkgs, ... }: {

  home.packages = [pkgs.hyprland];

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.systemPackages = [
    pkgs.waybar
    pkgs.dunst
    pkgs.libnotify

    pkgs.swww
    pkgs.kitty
    pkgs.rofi-wayland
  ];

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CUROSRS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesettings.enable = true;
  };

  #(pkgs.waybar.overrideAttrs (oldAttrs: {
  #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  #  })
  #)

  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [   
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-gtk
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };





}