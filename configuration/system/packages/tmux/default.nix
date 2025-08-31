{ pkgs, colorscheme, ... }:

let
  font = "#d75f00";
  acent = "#ffaf00";
  background = "#1C1C1C";
  #font = "#949494";
  #acent = "#d75f00";
  #background = "#1c1c1c";

in
{
  environment.etc = {
    "bash_completion.d/tmux-completion".source = ./completion.bash;
  };

  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "work";
      runtimeInputs = [ tmux ];
      #text = builtins.readFile ./script.sh;
      text = ''

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
              set-option -g status-right " :: [#{server_sessions}] [#S]" ';' \
              set-option -g status-left "[#W] ⮕ [#I/#{session_windows}] :: [#T] ⮕ [#P/#{window_panes}]"  ';' \
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
            set-option -g status-left "[#W]" ';' \
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
      #sidebar
      yank
      tmux-fzf
    ];

    extraConfig = ''
      set-option -g default-shell /run/current-system/sw/bin/bash
      set -g status on
      set -g renumber-windows on
      set -g display-time 3000
      set -g clock-mode-style 24
      set -g clock-mode-colour           "${acent}"


      set -g mode-style                  "fg=${acent},bg=${background}"
      set -g pane-border-style           "fg=${background}"
      set -g pane-active-border-style    "fg=${background}"
      set -g status-style                "fg=${font},bg=${background}"

      set -g window-status-style         "fg=${font},bg=${background}"
      set -g window-status-current-style "fg=${acent},bg=${background}"

      set -g message-style                "bg=${background},fg=${acent}"

      set -g status-position bottom
      set -g status-right ""
      set -g status-left "[#S]"
      set -g status-left-length 100
      set -g status-right-length 100


      set -g window-status-separator ""
      set -g status-justify right
      set -g window-status-format "[#I]"
      set -g window-status-current-format "[#I]"

      unbind i
      unbind r
      bind i set-option status
      bind S set-option pane-border-status
      bind-key '#' command-prompt -I "#{pane_title}" -p "(rename-pane):" "select-pane -T '%%'"

    '';
  };
}
