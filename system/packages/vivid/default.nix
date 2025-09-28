{ pkgs, colorscheme, ... }:

let
  theme = colorscheme.vivid;
in
{
  programs.vivid = {
    enable = true;
    theme = theme;
  };

  environment.variables.LS_COLORS = pkgs.lib.readFile (
    pkgs.runCommand "lscolors-vivid" { nativeBuildInputs = [ pkgs.vivid ]; } ''
      vivid generate ${theme} > $out
    ''
  );
}
