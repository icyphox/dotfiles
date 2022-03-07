package main

import (
	"fmt"
	"os"
	"strings"

	git "github.com/libgit2/git2go/v33"
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
	return path
}

func main() {
	if len(os.Args) != 3 {
		os.Exit(1)
	}

	gitDir := getGitDir(os.Args[2])
	switch os.Args[1] {
	case "-p":
		// current working directory
		home := os.Getenv("HOME")
		cwd := os.Args[2]
		fmt.Print(trimPath(cwd, home))
	case "-gb":
		branchCh := make(chan string)
		if len(gitDir) > 0 {
			repo, _ := git.OpenRepository(gitDir)
			go getGitBranch(repo)
			fmt.Print(<-branchCh)
		}
		fmt.Print("")
	case "-gs":
		statusCh := make(chan string) // git info
		if len(gitDir) > 0 {
			repo, _ := git.OpenRepository(gitDir)
			go getGitStatus(repo, "•", "×")
			fmt.Print(<-statusCh)
		}
		fmt.Print("")
	default:
		os.Exit(1)
	}
}
