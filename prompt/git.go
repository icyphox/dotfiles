package main

import (
	"os"
	"path/filepath"

	git "github.com/libgit2/git2go/v31"
)

// Recursively traverse up until we find .git
// and return the git repo path.
func getGitDir() string {
	cwd, _ := os.Getwd()
	for {
		dirs, _ := os.ReadDir(cwd)
		for _, d := range dirs {
			if ".git" == d.Name() {
				return cwd
			} else if cwd == "/" {
				return ""
			}
		}
		cwd = filepath.Dir(cwd)
	}
}

// Returns the current git branch or current ref sha.
func gitBranch(repo *git.Repository) string {
	ref, _ := repo.Head()
	if ref.IsBranch() {
		name, _ := ref.Branch().Name()
		return name
	} else {
		return ref.Target().String()[:7]
	}
}

// Returns • if clean, else ×.
func gitStatus(repo *git.Repository) string {
	sl, _ := repo.StatusList(&git.StatusOptions{
		Show:  git.StatusShowIndexAndWorkdir,
		Flags: git.StatusOptIncludeUntracked,
	})
	n, _ := sl.EntryCount()
	if n != 0 {
		return red("×")
	} else {
		return green("•")
	}
}
