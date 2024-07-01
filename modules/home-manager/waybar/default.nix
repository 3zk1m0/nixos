{ pkgs, inputs, ... }:

{

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 24;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "hyprland/window"
        ];

        modules-right = [
          "privacy"
          "idle_inhibitor"
          "pulseaudio"
          "group/hardware"
          "clock"
          "tray"
          "custom/wlogout"
        ];

        "group/hardware" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 500;
            "children-class" = "not-power";
            "transition-left-to-right" = false;
          };
          modules = [
            "battery"
            "cpu"
            "memory"
            "temperature"
            "backlight"
          ];
        };

        clock = {
          interval=  60;
          tooltip = true;
          format = "{:%H.%M}";
          "tooltip-format" = "{:%Y-%m-%d}";
        };

        cpu = {
          format = "  {usage}%";
          tooltip = false;
        };

        memory = {
          format = "  {}%";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };

        battery = {
          bat = "BAT0";
          interval = 60;
          states = {
              warning = 30;
              critical = 15;
          };
          format = "{capacity}% {icon} ";
          format-charging = "{capacity}% {icon} ";
          format-icons = ["" "" "" "" ""];
          max-length = 25;
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth ="{volume}% {icon}";
          format-mute = "";
          format-icon = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" ""];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
        };

        tray = {
          spacing = 4;
          icon-size = 16;
          icon-limit = 5;
          scroll- = 1;
        };

        "custom/wlogout" = {
          format = "  ";
          tooltip = false;
          on-click = "wlogout";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
              activated = " ";
              deactivated = " ";
          };
        };

      };
    };

    style = (builtins.readFile ./waybar.css);
  };

}
