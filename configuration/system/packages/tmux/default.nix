{ pkgs, colorscheme, ... }:

let
  theme = colorscheme.tmux;
in
{
  environment.etc = {
    "bash_completion.d/tmux-completion".source = ./completion.bash;
  };


  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "work";
      runtimeInputs = [ tmux ];
      text = builtins.readFile ./script.sh;
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
      set -g clock-mode-colour '${theme}'


      set -g mode-style "fg=${theme},bg=default"
      set -g pane-border-style "fg=default"
      set -g pane-active-border-style "fg=${theme}"
      set -g status-style "bg=default,fg=#AFAEAE"
      set -g window-status-style "fg=#AFAEAE,bg=default"
      set -g window-status-current-style "fg=${theme},bg=default"
      set -g message-style "bg=default,fg=${theme}"

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
