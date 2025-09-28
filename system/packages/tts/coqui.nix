{ pkgs, ... }:
{
  services.tts.servers = {
    default = {
      enable = true;
      port = 5050;
      model = "tts_models/es/css10/vits";
    };
  };
}
