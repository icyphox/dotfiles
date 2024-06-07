{ config
, pkgs
, ...
}:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
    extraConfig = ''
      set -g prefix C-q
      set -g set-titles on
      set-option -g set-titles-string "#T"
      unbind-key C-b
      bind-key C-q send-prefix
      set -g update-environment "KEYBOARD_LAYOUT"

      setw -g mode-keys vi

      bind r source-file ~/.config/tmux/tmux.conf

      # set-option -g default-terminal xterm-256color-italic
      # set -as terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[2 q'
      set escape-time 20

      set -g mouse on

      set -g base-index 1
      setw -g pane-base-index 1

      # pane binds
      bind -n M-n select-pane -D
      bind -n M-e select-pane -U
      bind -n M-y select-pane -L
      bind -n M-o  select-pane -R
      bind -n M-Up resize-pane -U 5
      bind -n M-Down resize-pane -D 5
      bind -n M-Left resize-pane -L 5
      bind -n M-Right resize-pane -R 5

      # window binds
      bind -n C-M-y previous-window
      bind -n C-M-o next-window
      bind-key \" split-window -v -c "#{pane_current_path}"
      bind-key c split-window -h -c "#{pane_current_path}"
      bind-key v new-window -c "#{pane_current_path}"
      bind-key s choose-session
      bind-key ) swap-window -t +2
      bind-key ( swap-window -t -1

      unbind -T copy-mode MouseDragEnd1Pane
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      bind P paste-buffer

      # pop-up pane to open urls
      bind-key u display-popup -E "xurls"

      # statusline on top
      set-option -g status-position top

      # statusline hide / unhide
      bind -n C-down set -q status off
      bind -n C-up set -q status on
      bind P paste-buffer

      set-window-option -g allow-rename off

      set -g pane-border-style fg=colour11
      set -g pane-active-border-style fg=colour8

      set -g status-justify right
      set -g status-right ""
      set -g status-left ""
      set -g status-style "bg=colour0"
      set -ag status-style "fg=colour7"

      set -g window-status-current-format "#[fg=colour15]    #W"
      set -g window-status-format "#[fg=colour8]    #W"

      set -g status-left-length 100
      set -ag status-left "#[fg=colour8]cwd #[fg=colour15]#(${pkgs.prompt}/bin/prompt cwd #{pane_current_path})   "
      set -ag status-left "#[fg=colour8]#(${pkgs.prompt}/bin/prompt vcs #{pane_current_path})   "

      # dim inactive pane
      set -g window-style 'fg=color8,bg=default'
      set -g window-active-style 'fg=color7,bg=default'

      set -g terminal-overrides ',xterm-256color:Tc'
      set -g default-terminal "tmux-256color"
      set -as terminal-overrides ',xterm*:sitm=\E[3m'

      set -g default-shell "/etc/profiles/per-user/icy/bin/fish"
      set -g default-command "/etc/profiles/per-user/icy/bin/fish"
    '';
  };
}
