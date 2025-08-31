WRAPPER_SESSION="${1:-$(basename "$PWD")}"
INNER_SESSION="${1:-$(uuidgen)}"

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

  if [[ -z ${TMUX-} ]]; then
    tmux -L default new-session -As default

  else
    socket_name="$(basename "${TMUX%%,*}")"

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

