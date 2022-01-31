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
	// items := strings.Split(path, "/")
	// truncItems := []string{}
	// for i, item := range items {
	// 	if i == (len(items) - 1) {
	// 		truncItems = append(truncItems, item)
	// 		break
	// 	}
	// 	truncItems = append(truncItems, item[:1])
	// }
	// return filepath.Join(truncItems...)
}

func main() {

	help := `usage: prompt OPTIONS PATH
	-p				path to truncate
	-gb				git branch
	-gs				git status`
	if len(os.Args) != 3 {
		fmt.Println(help)
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
			go getGitBranch(repo, branchCh)
			fmt.Print(<-branchCh)
		}
		fmt.Print("")
	case "-gs":
		statusCh := make(chan string) // git info
		if len(gitDir) > 0 {
			repo, _ := git.OpenRepository(gitDir)
			go getGitStatus(repo, statusCh)
			fmt.Print(<-statusCh)
		}
		fmt.Print("")
	default:
		fmt.Println(help)
		os.Exit(1)
	}
}
