{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "tmux-remove-orphaned-sockets";
      runtimeInputs = [ tmux ];
      text = builtins.readFile ./script.sh;
      meta.description = "Remove stale or orphaned Tmux sockets";
    })
  ];
}
