{ pkgs, ... }:
{

  environment.etc = {
    "bash_completion.d/ollama-completion".source = ./ollama-completion.bash;
  };

  services.ollama = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    gollama
    alpaca
  ];
}
