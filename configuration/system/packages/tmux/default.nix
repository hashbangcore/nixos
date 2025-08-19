{ pkgs, colorscheme, ... }:

let
  theme = colorscheme.tmux;
in
{
  environment.etc = {
    "bash_completion.d/tmux-completion".source = ./completion.bash;
  };

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
      # General settings
      set-option -g default-shell /run/current-system/sw/bin/bash
      #set -g mouse off
      set -g status on
      set -g renumber-windows on
      #set-window-option -g mode-keys vi
      set -g display-time 3000
      set -g clock-mode-style 24
      set -g clock-mode-colour '${theme}'

      # Color definitions (sintaxis compatible con tmux 3.5a)
      set -g mode-style "fg=${theme},bg=default"
      set -g pane-border-style "fg=#3c3c3c"
      set -g pane-active-border-style "fg=#AFAEAE"
      set -g status-style "bg=default,fg=#AFAEAE"
      set -g window-status-style "fg=#AFAEAE,bg=default"
      set -g window-status-current-style "fg=${theme},bg=default"
      set -g message-style "bg=default,fg=${theme}"

      # Status bar configuration
      set -g status-justify right
      set -g status-right ""
      set -g status-interval 5
      set -g status-left-length 30

      # Key bindings
      unbind i
      unbind r
      bind i set-option status

      # Neovim compatibility
      #set -g default-terminal "tmux-256color"
      #set -ga terminal-overrides ",*256col*:RGB"
      set -g set-titles on
      set -g set-titles-string "#{pane_title}"
    '';
  };
}
