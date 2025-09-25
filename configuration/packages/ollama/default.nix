{ pkgs, ... }:
{

  environment.etc = {
    "bash_completion.d/ollama-completion".source = ./ollama-completion.bash;
  };

  services.ollama = {
    enable = true;
    port = 11434;
  };

  environment.systemPackages = with pkgs; [
    gollama
  ];
}
