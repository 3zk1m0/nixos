{ pkgs, inputs, ... }: 

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1

    ${pkgs.swww}/bin/swww img ${./wallpaper.png} &
  '';
in
{

   wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {

      monitor = ",preferred,auto,auto";

      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";

      input = {
        "kb_layout" = "fi";

        "follow_mouse" = 1;

        touchpad = {
            natural_scroll = "yes";
            clickfinger_behavior = "yes";
            drag_lock = "yes";
            tap-and-drag = "yes";
        };

        sensitivity = 0; # -1.0 to 1.0, 0 means no modification.
      };

      bind = [
        "$mainMod, Q, exec, $terminal"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"

        "$mainMod, S, exec, rofi -show drun -show-icons"
      ];


      exec-once = ''${startupScript}/bin/start'';
    };
  };




}