{ pkgs, inputs, ... }:

{


  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];

    #style = ./wlogout.css;
    style = (builtins.replaceStrings ["{{lock_image}}" ] [ "${./lock.png}"] (builtins.readFile ./wlogout.css));


  };

}
# nix eval --expr '(builtins.readFile ./modules/home-manager/wlogout/wlogout.css)' --impure
# nix eval --expr 'builtins.replaceStrings ["{{lock_image}}" "${./lock.png}"] (builtins.readFile ./wlogout.css)' --impure
# nix eval --expr 'builtins.replaceStrings ["oo" "a"] ["a" "i"] (builtins.readFile ./modules/home-manager/wlogout/wlogout.css)' --impure
