# git Notes

## References
- [Understanding Git under the hood](https://medium.com/swlh/understanding-git-under-the-hood-b1aeae1d02f5)

## Commands
- Status
```git status```
git status -s
Less verbose
 Pull a repository
git clone https://github.com/project <local_directory>
Update local workspace with remote changes
git pull origin master
Command alias
Add one
git config --global alias.co checkout
List aliases
git config --global -l | grep alias
Committing
Stage or track a file
git add <file>
Remove a file from staging
git rm --cached <file>
Commit staged files
git commit -m "message"
Stage all modified, tracked files and commit
git commit -am "message"
Delete a file
rm <file>
git rm <file>
Commit
Move/rename a file
git mv <old> <new>
Commit
Workspace diffs
Staged files
git diff --cached
Non-staged files
git diff
Show most recent commits
https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History
git log -5
Shows 5  most recent commits
Tracked files
Show tracked files
git ls-tree -r master --name-only
Use HEAD instead of master for current branch
git log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d'
Include deleted files
Branches
Show branches (-a show remote branches)
git branch
git branch -v
git branch -vv
git show-branch
Create a new branch
git branch <branch>
Switch to a branch
git checkout <branch>
Merge branches
git checkout branch1
git merge branch2
Delete a branch
git branch -d <branch>
git push -d <remote branch>
git push origin -d <remote branch>
Pull vs. fetch
git pull is a git fetch followed by git merge.
git fetch pulls in the remote info put doesnt yet merge it into your local workspace.
Remote
git remote show origin
git checkout -b <local branch> <remote branch>
Checks out a remote branch and to a new local branch for editing.
git branch -u origin/<branch>
Set local branch to track remote branch (e.g., for fetch, pull, push).
Git Branching Workflow example
Setup ssh keys
git clone git@github.com:matthewjmiller1/rpc-transport-tests.git
git co -b test_branch
Do some work on test_branch
git commit -am test commit
git push origin test_branch
Creates remote test_branch and pushes changes
git co master
git merge test_branch
Merges test_branch locally
git branch --merged should show the branch has been merged
git push origin master
Makes remote have the merged contents
git branch -d test_branch
Delete the local branch
git push origin --delete test_branch
Delete the remote branch

