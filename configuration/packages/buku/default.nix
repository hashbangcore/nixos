{ pkgs, ... }:

{
  users.users."hash".packages = [ pkgs.buku ];

  environment.shellAliases = {
    bookmark = "buku --nc --np";
  };

  environment.etc = {
    "bash_completion.d/buku-completion".source = ./buku-completion.bash;
    "bash_completion.d/bookmark-completion".source = ./bookmark-completion.bash;
  };
}
