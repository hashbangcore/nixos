{ pkgs, ... }:
{
  services.tts.servers = {
    default = {
      enable = false;
      port = 5050;
      model = "tts_models/es/css10/vits";
    };
  };
}
