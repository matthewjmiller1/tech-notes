# MacOS Notes

## Configuration

### git ssh
- [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
    - Start ssh-agent
    ```
    eval "$(ssh-agent -s)"
    ```
    - Edit ```~/.ssh/config```
    ```
    Host *
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
    ```
    - Store in keychain
    ```
    ssh-add -K ~/.ssh/id_ed25519
    ```
    - Test connection
    ```
    ssh -T git@github.com
    ```
