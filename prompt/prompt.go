package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/go-git/go-git/v5"
	"github.com/go-git/go-git/v5/plumbing"
	"github.com/go-git/go-git/v5/plumbing/revlist"
)

func main() {
	if len(os.Args) < 3 {
		return
	}

	command := os.Args[1]
	target := os.Args[2]

	switch command {
	case "cwd":
		fmt.Print(cwd(target))
	case "vcs":
		if status := vcs(target); status != "" {
			fmt.Print(status)
		}
	}
}

func cwd(target string) string {
	home, _ := os.UserHomeDir()
	absTarget, _ := filepath.Abs(target)
	absHome, _ := filepath.Abs(home)

	// Replace home directory with ~
	if strings.HasPrefix(absTarget, absHome) {
		if absTarget == absHome {
			return "~"
		}
		absTarget = "~" + strings.TrimPrefix(absTarget, absHome)
	}

	// Truncate path components
	parts := strings.Split(filepath.ToSlash(absTarget), "/")
	for i := 0; i < len(parts)-1; i++ {
		if parts[i] != "" && parts[i] != "~" {
			parts[i] = parts[i][:1]
		}
	}
	return strings.Join(parts, "/")
}

func vcs(target string) string {
	repo := findRepo(target)
	if repo == nil {
		return ""
	}

	status := &strings.Builder{}

	// Get branch information
	if branch, ok := getBranch(repo); ok {
		status.WriteString(fmt.Sprintf("#[fg=colour8]%s ", branch))
	}

	// Get ahead/behind information
	if dist := getDistance(repo); dist != "" {
		status.WriteString(fmt.Sprintf("#[fg=colour8]%s", dist))
	}

	// Get repository status
	statusSymbol, statusColor := getRepoStatus(repo)
	status.WriteString(fmt.Sprintf("%s%s#[fg=colour7]", statusColor, statusSymbol))

	return status.String()
}

func findRepo(target string) *git.Repository {
	dir := filepath.Clean(target)
	for {
		repo, err := git.PlainOpen(dir)
		if err == nil {
			return repo
		}

		parent := filepath.Dir(dir)
		if parent == dir {
			return nil
		}
		dir = parent
	}
}

func getBranch(repo *git.Repository) (string, bool) {
	head, err := repo.Head()
	if err != nil {
		return "", false
	}

	if head.Name().IsBranch() {
		return head.Name().Short(), true
	}

	// Check for detached HEAD
	if commit, err := repo.CommitObject(head.Hash()); err == nil {
		return commit.Hash.String()[:7], true
	}

	return "", false
}

func getDistance(repo *git.Repository) string {
	head, err := repo.Head()
	if err != nil || !head.Name().IsBranch() {
		return ""
	}

	local := head.Hash()

	branch, err := repo.Branch(head.Name().Short())
	if err != nil {
		return ""
	}

	remoteName := "origin"

	remote, err := repo.Remote(remoteName)
	if err != nil {
		return ""
	}

	err = remote.Fetch(&git.FetchOptions{RemoteName: remoteName})
	if err != nil {
		return ""
	}

	refName := plumbing.Re

	ahead, _ := revlist.Objects(repo.Storer, []plumbing.Hash{local}, []plumbing.Hash{remote})
	behind, _ := revlist.Objects(repo.Storer, []plumbing.Hash{remote}, []plumbing.Hash{local})

	switch {
	case len(ahead) > 0 && len(behind) > 0:
		return "↑↓ "
	case len(ahead) > 0:
		return "↑ "
	case len(behind) > 0:
		return "↓ "
	default:
		return ""
	}
}

func getRepoStatus(repo *git.Repository) (string, string) {
	wt, _ := repo.Worktree()
	stat, _ := wt.Status()

	hasStaged := false
	hasUnstaged := false

	for _, s := range stat {

		if s.Staging != git.Unmodified {
			hasStaged = true
		}
		if s.Worktree != git.Unmodified {
			hasUnstaged = true
		}
	}

	switch {
	case hasUnstaged:
		return "×", "#[fg=colour1]"
	case hasStaged:
		return "±", "#[fg=colour3]"
	default:
		return "·", "#[fg=colour2]"
	}
}
