{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "work";
      runtimeInputs = [ tmux ];
      text = builtins.readFile ./script.sh;
      meta.description = "Attach or create tmux session based on current directory";
    })
  ];
}
