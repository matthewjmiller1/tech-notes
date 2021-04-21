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

### sed/awk
- Sum column with negative numbers
    ```
    awk '{ s += $4} END { printf("%.2f\n", s) }'
    ```
- Sum over select line numbers
    ```
    sed -n '9,16p' file.txt | awk '{ s += $4} END { printf("%.2f\n", s) }'
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
