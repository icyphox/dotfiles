{ config
, pkgs
, ...
}:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Anirudh Oppiliappan";
        email = "x@icyphox.sh";
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };

      git.sign-on-push = true;
      git.write-change-id-header = true;

      ui.paginate = "never";
      ui.default-command = [ "log" "-n" "10" ];
      template-aliases = {
        custom_log_compact = ''
          if(root,
            format_root_commit(self),
            label(if(current_working_copy, "working_copy"),
              concat(
                separate(" ",
                  format_short_change_id_with_hidden_and_divergent_info(self),
                  author.name(),
                  bookmarks,
                  tags,
                  working_copies,
                  if(conflict, label("conflict", "conflict")),
                  if(empty, label("empty", "(empty)")),
                  if(description,
                    description.first_line(),
                    label(if(empty, "empty"), description_placeholder),
                  ),
                ) ++ "\n",
              ),
            )
          )
        '';
      };

      templates = {
        log = "custom_log_compact";
      };
    };
  };
}
