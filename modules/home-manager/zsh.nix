{ pkgs, config, ... }: {

  # home.packages = [ pkgs.unstable.git ];

  programs.zsh = {
    enable = true;
    autocd = false;
    #autosuggestions.enable = true;
    enableCompletion = true;
    # defaultKeymap = "emacs";
    history.size = 10000;
    history.save = 10000;
    history.expireDuplicatesFirst = true;
    history.ignoreDups = true;
    history.ignoreSpace = true;
    history.share = false;
    historySubstringSearch.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "eastwood";
    };


    plugins = [];

    shellAliases = {
      "..." = "./..";
      "...." = "././..";
      gc = "nix-collect-garbage --delete-old";
      refresh = "source ${config.home.homeDirectory}/.zshrc";
      show_path = "echo $PATH | tr ':' '\n'";

      pbcopy = "/mnt/c/Windows/System32/clip.exe";
      pbpaste = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command 'Get-Clipboard'";
      explorer = "/mnt/c/Windows/explorer.exe";

      reload-nix = "sudo nixos-rebuild switch --flake ~/configuration";
    };

    initExtra = ''
      . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
    '';

    envExtra = ''
      export PATH=$PATH:$HOME/.local/bin
    '';

  };

}
