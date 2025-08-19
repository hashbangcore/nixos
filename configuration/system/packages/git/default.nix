{
  environment = {
    variables = {
      GIT_SSH_COMMAND = "ssh -F /data/secrets/development/credentials/config";
    };
  };
  programs.git = {
    lfs = {
      enable = true;
    };
    enable = true;
    config = {
      user = {
        name = "Hash";
        email = "hashbangcore@duck.com";
        signingkey = "C9D6449D379AFF8D";
      };
      init = {
        defaultBranch = "development";
      };
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoStash = true;
      };
      tag = {
        gpgSign = true;
      };
      commit = {
        gpgsign = true;
      };
    };
  };
}
