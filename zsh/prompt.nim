import nicy, strformat

let
  prompt = color("› ", "magenta")
  nl = "\n"
  gitBranch = color(gitBranch(), "yellow")
  cwd = color(tilde(getCwd()), "cyan")
  dirty = color("×", "red")
  clean = color("•", "green")
  g = gitBranch & gitStatus(dirty, clean)
  git = italics(g)
  venv = color(virtualenv(), "red")


# the prompt
echo fmt"{nl}{venv}{cwd}{git}{nl}{prompt}"
