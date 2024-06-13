{ pkgs, ... }: {

  home.packages = [pkgs.git];

  programs.git = {
      enable = true;
      package = pkgs.git;
      delta.enable = true;

      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = "sander.kallio@monad.fi";
      userName = "3zk1m0";
      extraConfig = {
        # FIXME: uncomment the next lines if you want to be able to clone private https repos
        # url = {
        #   "https://oauth2:${secrets.github_token}@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
        #     insteadOf = "https://gitlab.com";
      #   };
        # };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        diff = {
          colorMoved = "default";
        };
      };
      ignores = [
        "devbox.json"
        "devbox.lock"
      ];
    };

}
