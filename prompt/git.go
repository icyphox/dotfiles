package main

import (
	"os"
	"path/filepath"

	git "github.com/libgit2/git2go/v33"
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
	// Quick hack to fix crash when ref is nil;
	// i.e., new repo with no commits.
	if ref == nil {
		return "no commit"
	}
	if ref.IsBranch() {
		name, _ := ref.Branch().Name()
		return name
	} else {
		return ref.Target().String()[:8]
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
		return "×"
	} else {
		return "•"
	}
}
