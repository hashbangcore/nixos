{ pkgs, ... }:
let
  color = {
    black = "#1C1C1C";
    grey = "#949494";
    orange = "#d75f00";
    white = "#fafafb";
    yellow = "#ffaf00";
    red = "red";
  };

  theme = {
    dark = {
      alert = color.red;
      acent = color.orange;
      background = color.black;
      font = color.grey;
    };
    light = {
      alert = color.red;
      acent = color.yellow;
      background = color.white;
      font = color.black;
    };
  };

  colorscheme = c: ''
    set -g message-command-style         "fg=${c.alert},bg=default"
    set -g clock-mode-colour             "${c.acent}"
    set -g display-panes-active-colour   "${c.acent}"
    set -g display-panes-colour          "${c.acent}"
    set -g message-style                 "fg=${c.acent},bg=default"
    set -g mode-style                    "fg=${c.acent},bg=default"
    set -g pane-active-border-style      "fg=${c.background}"
    set -g pane-border-style             "fg=${c.background}"
    set -g status-left                   "[#[fg=${c.acent}]#S#[fg=${c.font}]]"
    set -g status-right                  ""
    set -g status-style                  "fg=${c.font},bg=default"
    set -g window-status-current-format  "#[fg=${c.font}][#[fg=${c.acent}]#I#[fg=${c.font}]]"
    set -g window-status-current-style   "fg=${c.acent},bg=${c.background}"
    set -g window-status-format          "[#I]"
    set -g window-status-style           "fg=${c.font},bg=${c.background}"


    #bind-key s choose-tree -s -F '#{?session_attached,#[fg=green]#[bg=red],#[fg=green]#[bg=red]} #{session_name}: #{session_windows}#{?session_attached, (attached),}'
    #  #{?CONDITION,TRUE-FORMAT,FALSE-FORMAT}
    # #{==:#T,master,pane,#T}


  '';

  script = c: ''
    if [ "$#" -eq 0 ]; then
        WRAPPER_SESSION=$(basename "$PWD")
        INNER_SESSION="$(uuidgen)"
    else
        WRAPPER_SESSION="$1"
        INNER_SESSION="$1"
    fi

    removeOrphaned(){
      for s in "/run/user/$(id -u)/tmux-$(id -u)"/*; do
        if ! tmux -L "$(basename "$s")" ls &>/dev/null; then
          rm -f "$s"
        fi
      done
    }

    startWrapper(){
      if tmux -L "$WRAPPER_SESSION" has-session -t "$WRAPPER_SESSION" 2>/dev/null; then
        tmux -L "$WRAPPER_SESSION" attach -t "$WRAPPER_SESSION"
      else
        tmux -L "$WRAPPER_SESSION" new -s "$WRAPPER_SESSION" ';' \
          set-option -g prefix M-Space ';' \
          set-option -g status-right " :: [#[fg=${c.acent}]#{server_sessions}#[fg=${c.font}]][#[fg=${c.acent}]#S#[fg=${c.font}]]" ';' \
          set-option -g status-left "[#[fg=${c.acent}]#W#[fg=${c.font}]] ⮕ [#[fg=${c.acent}]#I#[fg=${c.font}]/#{session_windows}] :: [#[fg=${c.acent}]#T#[fg=${c.font}]] ⮕ [#[fg=${c.acent}]#P#[fg=${c.font}]/#{window_panes}]"  ';' \
          set-option -g pane-border-status top ';' \
          set-option -g pane-border-indicators off ';' \
          set-option -g pane-border-format "" ';' \
          set-option -g status-justify right  ';' \
          set-option -g status-position top
      fi
    }

    startInner() {
      tmux -L "$WRAPPER-inner" new-session -A -t "$WRAPPER" -s "$INNER_SESSION" ';' \
        set-option -g pane-border-status off ';' \
        set-option -g status-position bottom ';' \
        set-option -g status-left "[#[fg=${c.acent}]#W#[fg=${c.font}]]" ';' \
        set-option -g status-justify right
    }

    main() {
      removeOrphaned
      if ! [[ -v TMUX ]]; then
        tmux -L default new-session -As default
      else
        socket_name="$(basename "$(echo "$TMUX"| cut --delimiter="," --fields=1)")"
        if [[ $socket_name == "default" ]]; then
          tmux -L default set-option prefix C-b
          tmux -L default set-option status off
          export WRAPPER=$WRAPPER_SESSION
          startWrapper
        else
          startInner
        fi
      fi
    }; main
  '';
in
{
  environment.etc = {
    "bash_completion.d/tmux-completion".source = ./completion.bash;
  };

  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "work";
      runtimeInputs = [ tmux ];
      text = script theme.dark;
      meta.description = "Attach or create tmux session based on current directory";
    })
  ];

  programs.tmux = {
    enable = true;
    shortcut = "Space";
    newSession = false;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    terminal = "tmux-256color";
    escapeTime = 10;
    historyLimit = 10000;
    aggressiveResize = true;
    resizeAmount = 10;
    secureSocket = true;
    plugins = with pkgs.tmuxPlugins; [
      fzf-tmux-url
      sidebar
      yank
      tmux-fzf
    ];

    extraConfig = ''
      set-option -g default-shell /run/current-system/sw/bin/bash
      set -g status on
      set -g renumber-windows on
      set -g display-time 3000
      set -g clock-mode-style 24
      set -g status-position bottom

      set -g status-left-length 100
      set -g status-right-length 100


      set -g window-status-separator ""
      set -g status-justify right


      unbind i
      unbind r
      bind i set-option status
      bind S set-option pane-border-status
      bind-key '#' command-prompt -I "#{pane_title}" -p "(rename-pane):" "select-pane -T '%%'"


      ${colorscheme theme.dark}
    '';
  };
}
