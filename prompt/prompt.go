package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	git "github.com/libgit2/git2go/v33"
)

const (
	promptSym = "▲"
)

// Truncates the current working directory:
//   /home/icy/foo/bar -> ~/f/bar
func trimPath(cwd, home string) string {

	var path string
	if strings.HasPrefix(cwd, home) {
		path = "~" + strings.TrimPrefix(cwd, home)
	} else {
		// If path doesn't contain $HOME, return the
		// entire path as is.
		path = cwd
		return path
	}
	items := strings.Split(path, "/")
	truncItems := []string{}
	for i, item := range items {
		if i == (len(items) - 1) {
			truncItems = append(truncItems, item)
			break
		}
		truncItems = append(truncItems, item[:1])
	}
	return filepath.Join(truncItems...)
}

func makePrompt() string {
	cwd, _ := os.Getwd()
	home := os.Getenv("HOME")
	gitDir := getGitDir()
	if len(gitDir) > 0 {
		repo, _ := git.OpenRepository(getGitDir())
		return fmt.Sprintf(
			"\n%s (%s %s)\n%s",
			trimPath(cwd, home),
			gitBranch(repo),
			gitStatus(repo),
			promptSym,
		)
	}
	return fmt.Sprintf(
		"\n%s\n%s",
		trimPath(cwd, home),
		promptSym,
	)
}

func main() {
	fmt.Println(makePrompt())
}
