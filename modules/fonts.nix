{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    jetbrains-mono
    nerd-font-patcher
  ];
}
