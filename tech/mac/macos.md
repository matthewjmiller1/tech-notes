# MacOS Notes

## Configuration

### Homebrew

- [Useful Commands for Package Management in Homebrew](https://gist.github.com/jamesmurdza/6e5f86bae7d3b3db4201a52045a5e477)
    - Show dependencies of all leaf packages (i.e., root level packages that are
      not a dependency of any other package)
      ```
      brew deps --tree $(brew leaves)
      ```

### git ssh

- [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
    - Start ssh-agent
    ```
    eval "$(ssh-agent -s)"
    ```

    - Edit `~/.ssh/config`
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

### Enabling italics in iterm2

- [Enabling italics in vim syntax highlighting for mac terminal](https://stackoverflow.com/questions/1326998/enabling-italics-in-vim-syntax-highlighting-for-mac-terminal)
    - In file `~/tmp/terminfo`:
    ```
    # A xterm-256color based TERMINFO that adds the escape sequences for italic.
    xterm-256color-italic|xterm with 256 colors and italic,
      sitm=\E[3m, ritm=\E[23m,
      use=xterm-256color,
    ```

    - Generate a terminfo file:
    ```
    tic ~/tmp/terminfo
    ```

    This generates `~/.terminfo/78/xterm-256color-italic`. Now you can set
    `TERM=xterm-256color-italic` and set it in the iterm2 profile:
    `Preferences > Profiles > Terminal > Report Terminal Type`.

## Applications

### Wireshark

- Must open second instance to have multiple `.pcap` files opened at once. Use
  the terminal command `open -n /Applications/Wireshark.app` to open the second
  instance.
