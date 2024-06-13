{ pkgs, inputs, ... }:

{

  services.dunst = {
    enable = true;

    settings = {
      global = {
        corner_radius = 8;
        transparency = 50;
        offset = "30x50";
      };
  
      urgency_low = {
        background = "#37474f";
        foreground = "#33ccffee";
        frame_color = "#33ccffee";
        timeout = 10;
      };
      
      urgency_normal = {
        background = "#37474f";
        foreground = "#00ff99ee";
        frame_color = "#00ff99ee";
        timeout = 10;
      };
      
      urgency_critical = {
        background = "#37474f";
        foreground = "#FF3131ee";
        frame_color = "#FF3131ee";
        timeout = 10;
      };

    };

  };

}
