# git Notes

## References
- [Understanding Git under the hood](https://medium.com/swlh/understanding-git-under-the-hood-b1aeae1d02f5)

## Commands
- Status
    ```
    git status
    ```
    - Less verbose
        ```
        git status -s
        ```
- Pull a repository
    ```
    git clone https://github.com/project <local_directory>
    ```
- Update local workspace with remote changes (origin is just an alias for the
  remote
    ```
    git pull origin master
    ```
- Show remotes
    ```
    git remote -v
    ```
- Command alias
    - Add one
        ```
        git config --global alias.co checkout
        ```
    - List aliases
        ```
        git config --global -l | grep alias
        ```
- Committing
    - Stage or track a file
        ```
        git add <file>
        ```
    - Remove a file from staging
        ```
        git rm --cached <file>
        ```
    - Commit staged files
        ```
        git commit -m "message"
        ```
    - Stage all modified, tracked files and commit
        ```
        git commit -am "message"
        ```
    - Delete a file
        ```
        rm <file>
        git rm <file>
        ```
- Move/rename a file
    ```
    git mv <old> <new>
    ```
- Workspace diffs
    - Staged files
        ```
        git diff --cached
        ```
    - Non-staged files
        ```
        git diff
        ```
- [Show most recent commits](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History)
    - Shows 5 most recent commits
        ```
        git log -5
        ```
- Tracked files
    - Show tracked files (use "HEAD" of "master" current branch)
        ```
        git ls-tree -r master --name-only
        ```
    - Include deleted files
        ```
        git log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d'
        ```
- Branches
    - Show branches (-a show remote branches)
        ```
        git branch
        git branch -v
        git branch -vv
        git show-branch
        ```
    - Create a new branch
        ```
        git branch <branch>
        ```
    - Switch to a branch
        ```
        git checkout <branch>
        ```
    - Merge branches
        ```
        git checkout branch1
        git merge branch2
        ```
    - Delete a branch
        ```
        git branch -d <branch>
        git push -d <remote branch>
        git push origin -d <remote branch>
        ```
    - Pull vs. fetch
        - git pull is a git fetch followed by git merge.
        - git fetch pulls in the remote info put doesn't yet merge it into your
          local workspace.
    - Remote
        ```
        git remote show origin
        - Checks out a remote branch and to a new local branch for editing.
            ```
            git checkout -b <local branch> <remote branch>
            ```
        - Set local branch to track remote branch (e.g., for fetch, pull, push).
            ```
            git branch -u origin/<branch>
            ```
- Git Branching Workflow example
    ```
    # Setup ssh keys
    git clone git@github.com:matthewjmiller1/rpc-transport-tests.git
    git co -b test_branch
    # Do some work on test_branch
    git commit -am "test commit"

    # Create remote test_branch and pushes changes
    git push origin test_branch

    git co master

    # Merge test_branch locally
    git merge test_branch
    # "git branch --merged" should show the branch has been merged

    # Make remote have the merged contents
    git push origin master

    # Delete the local branch
    git branch -d test_branch

    # Delete the remote branch
    git push origin --delete test_branch
    ```

- Using a local repo to push/pull from multiple remote repos
    - Proxied client
        - Cloning
            ```
            git clone -b <remote_branch> --single-branch <remote_repo2>
            ```
        - Pull/push
            ```
            git pull/push origin <remote_branch>
            ```
    - Open client
        - Setup
            ```
            git clone <remote_repo1>
            git co -b <proxy_branch>
            git remote add <remote_origin> <remote_repo2>
            git push <remote_origin> <proxy_branch>
            ```
        - Pull/push (example for pulling changes from proxied client and pushing
          them to public repo)
            ```
            git co <proxy_branch>
            git pull <remote_origin> <proxy_branch>
            git co main
            git merge <proxy_branch>
            git push origin main
            ```

- Divergent branch options
    - In 2.27.0, a warning was added about behavior on reconciling divergent
      branches.
        - [Git warning: Pulling without specifying how to reconcile divergent branches is discouraged](https://salferrarello.com/git-warning-pulling-without-specifying-how-to-reconcile-divergent-branches-is-discouraged/) 
        - [How to deal with this git warning? “Pulling without specifying how to
          reconcile divergent branches is
          discouraged”](https://stackoverflow.com/questions/62653114/how-to-deal-with-this-git-warning-pulling-without-specifying-how-to-reconcile)
    - Recommendation is to make fast-forward only the default behavior and then
      explicitly do merge commit or rebase when required.
        - Set fast-forward as default
            ```
            git config --global pull.ff only
            ```
        - Rebase
            ```
            git pull --rebase
            ```
        - Merge commit
            ```
            git fetch
            git merge origin/<branchname>
            ```
            or
            ```
            git pull -c pull.ff=false pull
            ```
