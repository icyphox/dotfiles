package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/go-git/go-git/v5"
)

const (
	promptSym = "▲"
)

var (
	red   = color("\033[31m%s\033[0m")
	green = color("\033[32m%s\033[0m")
	cyan  = color("\033[36m%s\033[0m")
)

func color(s string) func(...interface{}) string {
	return func(args ...interface{}) string {
		return fmt.Sprintf(s, fmt.Sprint(args...))
	}
}

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
		repo, _ := git.PlainOpen(getGitDir())
		return fmt.Sprintf(
			"\n%s (%s %s)\n%s",
			cyan(trimPath(cwd, home)),
			gitBranch(repo),
			gitStatus(repo),
			promptSym,
		)
	}
	return fmt.Sprintf(
		"\n%s\n%s",
		cyan(trimPath(cwd, home)),
		promptSym,
	)
}

func main() {
	fmt.Println(makePrompt())
}
