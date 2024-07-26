{ pkgs, inputs, ... }: 

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    pidof ${pkgs.waybar}/bin/waybar || ${pkgs.waybar}/bin/waybar &
    pidof ${pkgs.hypridle}/bin/hypridle || ${pkgs.hypridle}/bin/hypridle &
    pidof ${pkgs.networkmanagerapplet}/bin/nm-applet || ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
    pidof ${pkgs.hyprpaper}/bin/hyprpaper || "${pkgs.hyprpaper}/bin/hyprpaper"
    pidof ${pkgs.copyq}/bin/copyq || "${pkgs.copyq}/bin/copyq --start-server"
    pidof ${pkgs.udiskie}/bin/udiskie || "${pkgs.udiskie}/bin/udiskie &"
    blueman-applet &
  ''; 

in
{

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemdIntegration = true;
    systemd.variables = ["--all"];
    settings = {

      source = "~/.config/hypr/monitors.conf";

      monitor = [
        ",preferred,auto,auto,bitdepth,10"
      ];

      env = [
        "HYPRCURSOR_SIZE,24"
        # "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2"
      ];

      workspace = [
        "monitor:DP-2 r[1,10]"
      ];


      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";

      input = {
        kb_layout = "fi";
        numlock_by_default = true;
        # accel_profile = "flat";
        # sensitivity = 0.5; # -1.0 to 1.0, 0 means no modification.
        follow_mouse = 2;

        touchpad = {
          natural_scroll = "yes";
          clickfinger_behavior = "yes";
          drag_lock = "yes";
          tap-and-drag = "yes";
          scroll_factor = 0.5;
        };

      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 2;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" =" rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = "false";
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 8;
        
        blur = {
            enabled = "false";
            size = 3;
            passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

      };

      windowrulev2 = "suppressevent maximize, class:.*";


      bind = [

        ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        "$mainMod, V, exec, clipman pick -t wofi"

        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit, "
        "$mainMod, E, exec, $fileManager"
        "$mainMod, G, togglefloating, "
        "$mainMod, F, fullscreen, " # toggle fullscreen
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle
        "$mainMod, L, exec, hyprlock"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, S, exec, rofi -show drun -show-icons"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "float,(pavucontrol)"
        "float,(blueman-manager)"
      ];

      exec = [
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      exec-once = [
        ''${startupScript}/bin/start''
      ];

    };
    extraConfig = ''
      device {
        name=logitech-mx-vertical-1
        sensitivity=0.5
        accel_profile=adaptive
      }
    '';
  };




}
