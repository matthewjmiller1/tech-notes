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

### tc
- Use [pedit](https://man7.org/linux/man-pages/man8/tc-pedit.8.html) to modify
  egress packets with a destination port of 50001 to have a source IP address of
  172.20.0.3 and recalculate the IP and TCP checksums.
    ```
    tc qdisc replace dev eth0 root handle 1: htb
    tc filter add dev eth0 parent 1: u32 match ip dport 50001 0xffff action pedit ex munge ip src set 172.20.0.3 pipe csum ip and tcp
    ```

## Tools

### Networking
#### Stats
- netstat replacements in Linux:
    - [ss(8)](https://man7.org/linux/man-pages/man8/ss.8.html) for socket stats.
    - [nstat(8)](https://man7.org/linux/man-pages/man8/nstat.8.html) to show
      SNMP network stats (global counters like ```netstat -s```).
        - Use ```nstat -azs``` for the closest to ```netstat -s``` behavior
          because the ```nstat``` default it to show incremental, non-zero
          counters.
    - [ip(8)](https://man7.org/linux/man-pages/man8/ip.8.html) to set and show
      network configuration

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

## NFS tracing
- [RHEL NFS issue](https://access.redhat.com/solutions/4148851)
    ```
    rpcdebug -m nlm -s all
    rpcdebug -m rpc -s all
    <test>
    rpcdebug -m nlm -c all
    rpcdebug -m rpc -c all
    ```
    - [rpcdebug(8)](https://linux.die.net/man/8/rpcdebug)
    - May be replaced by sunprc tracepoints in the future.

## Kernel Tracing
- [Linux Tracing Technologies](https://www.kernel.org/doc/html/latest/trace/index.html)

### Event Tracing
- Show events that can be traced:
```
sudo ls /sys/kernel/debug/tracing/events
sudo ls /sys/kernel/debug/tracing/events/syscalls
```
- See if tracing is enabled for event:
```
sudo cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_write/enable
```
- Enable/disable tracing for an event:
```
sudo echo 1 > /sys/kernel/debug/tracing/events/syscalls/sys_enter_write/enable
sudo echo 0 > /sys/kernel/debug/tracing/events/syscalls/sys_enter_write/enable
```
- Show format for event:
```
root@9c8834f35ca7:/# cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_write/format 
name: sys_enter_write
ID: 685
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
	field:unsigned int fd;	offset:16;	size:8;	signed:0;
	field:const char * buf;	offset:24;	size:8;	signed:0;
	field:size_t count;	offset:32;	size:8;	signed:0;

print fmt: "fd: 0x%08lx, buf: 0x%08lx, count: 0x%08lx", ((unsigned long)(REC->fd)), ((unsigned long)(REC->buf)), ((unsigned long)(REC->count))
root@9c8834f35ca7:/#
```

### Show Traces
- Non-consuming read (leaves traces from file)
```
sudo cat /sys/kernel/debug/tracing/trace
```
- Consuming read (removes traces from file)
```
sudo cat /sys/kernel/debug/tracing/trace_pipe
```
- Clear all traces
```
sudo echo > /sys/kernel/debug/tracing/trace
```

## Configuration

### sudo Access
- In [Ubuntu](https://linuxize.com/post/how-to-add-user-to-sudoers-in-ubuntu/),
  ```visudo``` and add to the end of ```/etc/sudoers``` (change "username" to
  the username being given sudo access):
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
#### lxc
- [What's LXC?](https://linuxcontainers.org/lxc/introduction/)
- [LXC manpages](https://linuxcontainers.org/lxc/manpages/index.html)
    - [lxc-create(1)](https://linuxcontainers.org/lxc/manpages/man1/lxc-create.1.html)
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
