# works only on X11


{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (writeScriptBin "toggle-sticky-above" ''
      #!/usr/bin/env bash

      ACTIVE=$(xdotool getactivewindow)

      if xprop -id $ACTIVE | grep -q '_NET_WM_STATE_ABOVE'; then
          wmctrl -i -r $ACTIVE -b remove,sticky,above
      else
          wmctrl -i -r $ACTIVE -b add,sticky,above
      fi

    '')
  ];
}
