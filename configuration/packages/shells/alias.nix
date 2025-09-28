{
  environment = {
    shellAliases = {
      cp = "cp --reflink=auto";
      l = "tree -L 1";
      ls = "LC_ALL=C ls --color=tty --indicator-style=slash";
      rm = "gtrash put";
    };
  };
}
