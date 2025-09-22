{ pkgs, ... }:
let
  dependencies = with pkgs; [
    xclip
    wl-clipboard
  ];
in
{
  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "clip-copy";
      runtimeInputs = dependencies;
      text = ''
        if [ -v WAYLAND_DISPLAY ]; then
          wl-copy
        else
          xclip -selection clipboard
        fi
      '';
      meta.description = "Copy from stdin to clipboard using xclip or wl-clipboard on Wayland";
    })

    (writeShellApplication {
      name = "clip-paste";
      runtimeInputs = dependencies;
      text = ''
        if [ -v WAYLAND_DISPLAY ]; then
          wl-paste
        else
          xclip -o -selection clipboard
        fi
      '';
      meta.description = "Paste from clipboard to stdout using xclip or wl-clipboard on Wayland";
    })
  ];
}
