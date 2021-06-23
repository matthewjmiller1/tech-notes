# Linux Notes

## Commands
### bash
- Print commands as they are executed
    ```
    set -x
    ```
- Using basename with xargs
    ```
    ls | xargs -I % sh -c 'mv % new_path/$(basename %)'
    ```
- Change .h files to .hpp files
    ```
    ls *.h | xargs -I % sh -c 'mv % $(dirname %)/$(basename % .h).hpp'
    ```
- Dump environment variables
    ```
    env
    ```
- Show all shell functions and environment variables
    ```
    set
    ```
- Show bash function implementation
    ```
    typeset -f <function>
    ```
- To print the current PID of a script
    ```
    echo $$
    ```

- Check if environment variable is set
    ```
    [ -n "${VAR+x}" ] ## Fails if VAR is unset
    [ -n "${VAR:+x}" ] ## Fails if VAR is unset or empty (doesn't work)
    [ -n "${VAR-x}" ] ## Succeeds if VAR is unset
    [ -n "${VAR:-x}" ] ## Succeeds if VAR is unset or empty (doesn't work)
    ```

- To remove a directory from the PATH
    ```
    export PATH=$(echo $PATH | sed 's#:/path/to/remote/##')
    ```

- Use xargs with a bash function
    ```
    ls | grep "dir/" | xargs bash -c '<function> "$@"' _
    ```

- To output man pages
    ```
    man <command> | col -b > filename.txt
    ```

- Edit command line with ```$EDITOR```
    ```
    <CTRL+X> <CTRL+E>
    ```

- Show build-in options
    ```
    set -o
    ```

- Fix bracket mode paste
    ```
    $ cat ~/fix_paste
    #!/bin/bash

    printf "\e[?2004l"
    $
    ```

### sed/awk
- Sum column with negative numbers
    ```
    awk '{ s += $4} END { printf("%.2f\n", s) }'
    ```
- Sum over select line numbers
    ```
    sed -n '9,16p' file.txt | awk '{ s += $4} END { printf("%.2f\n", s) }'
    ```

### grep
- [Search for non-ASCII (e.g., unicode) characters](https://stackoverflow.com/questions/3001177/how-do-i-grep-for-all-non-ascii-characters)
    ```
    grep --color='auto' -r -P -n "[^\x00-\x7F]" .
    ```

### vim
- [Search for non-ASCII characters](https://stackoverflow.com/questions/16987362/how-to-get-vim-to-highlight-non-ascii-characters)
    ```
    /[^\x00-\x7F]
    ```

## Tools

### Networking
#### Test Connections
- [nc](http://www.freebsd.org/cgi/man.cgi?query=nc)
- [ncat](http://nmap.org/ncat/)

#### Packet Injector/Generator:
- [nping](http://nmap.org/nping/)

#### Port Scanner
- [nmap](http://nmap.org/book/man.html)

#### Bandwidth Testers
- http://en.wikipedia.org/wiki/Netperf
- http://en.wikipedia.org/wiki/Iperf
- http://en.wikipedia.org/wiki/Ttcp
- http://en.wikipedia.org/wiki/Bwping
- http://en.wikipedia.org/wiki/Flowgrind

#### Network Emulator
- [netem](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem)
- [tc](http://man7.org/linux/man-pages/man8/tc-netem.8.html)

#### Observe Kernel Packet Drops
- [dropwatch](https://linux.die.net/man/1/dropwatch)

#### Virtual Interfaces
- [Introduction to Linux interfaces for virtual networking](https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking)

## Configuration

### sudo Access
- In [Ubuntu](https://linuxize.com/post/how-to-add-user-to-sudoers-in-ubuntu/),
  ```visudo``` and add to the end of ```/etc/sudoers```:
    ```
    username  ALL=(ALL) NOPASSWD:ALL
    ```

### Linux cgroups
- Run cgconfig
    ```
    systemctl start cgconfig.service
    systemctl stop cgconfig.service
    ```
- Create a cgroup (creates ```/sys/fs/cgroup/memory/group1/```)
    ```
    cgcreate -g memory:group1
    ```
- Delete a cgroup
    ```
    cgdelete -g memory:group1
    ```
- Add a process to a group
    ```
    cgclassify -g memory:group1 <pid>
    ```
- Show mounted cgroup controllers
    ```
    lssubsys
    ```

### Linux Namespaces
#### Utilities
- Network namespaces
    - Create
        ```
        ip netns add myns1
        ```
    - Delete
        ```
        ip netns del myns1
        ```
    - List
        ```
        ip netns list
        ```
    - Monitor for add/remove of network namespaces
        ```
        ip netns monitor
        ```
    - Move eth0 to namespace
        ```
        ip link set eth0 netns myns1
        ```
    - Start bash in namespace
        ```
        ip netns exec myns1 bash
        ```
    - Exec a command in all net namespaces
        ```
        ip -all netns exec ip link
        ```
#### Locations
- Files for each namespace (e.g., network): ```/var/run/netns/```
- For a proc: ```/proc/<pid>/ns/net/```
- For a thread: ```/proc/<pid>/task/<tid>/ns/net/```
