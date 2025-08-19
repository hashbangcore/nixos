{ pkgs, ... }:

{

  environment = {
    variables = {
      EDITOR = "edit";
    };
    systemPackages = with pkgs; [
      (writeShellApplication {
        name = "edit";
        runtimeInputs = [
          vis
          pwgen
        ];
        text = builtins.readFile ./script.sh;
        meta = {
          description = "Open text editor: vis for root, neovim with theme for regular users";
        };
      })
    ];
  };
}
