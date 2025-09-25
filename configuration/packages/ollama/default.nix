{ pkgs, unstable, ... }:
let
  blueprint-compiler = unstable.callPackage ./blueprinter/package.nix { };
  alpaca-local = unstable.callPackage ./alpaca/package.nix { };
  alpaca-with-blueprint = alpaca-local.overrideAttrs (old: {
    nativeBuildInputs = old.nativeBuildInputs ++ [ blueprint-compiler ];
  });
in
{

  environment.etc = {
    "bash_completion.d/ollama-completion".source = ./ollama-completion.bash;
  };

  services.ollama = {
    enable = true;
    port = 11434;
  };

  environment.systemPackages = [
    pkgs.gollama
    alpaca-with-blueprint
  ];
}
