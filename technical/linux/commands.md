# Linux Commands

## bash
- Print commands as they are executed\
```set -x```

- Using basename with xargs\
```ls | xargs -I % sh -c 'mv % new_path/$(basename %)'```

- Change .h files to .hpp files\
```ls *.h | xargs -I % sh -c 'mv % $(dirname %)/$(basename % .h).hpp'```

- Dump environment variables\
```env```

- Show all shell functions and environment variables\
```set```

- Show bash function implementation\
```typeset -f <function>```

- To print the current PID of a script\
```echo $$```

## sed/awk
- Sum column with negative numbers\
```awk '{ s += $4} END { printf("%.2f\n", s) }'```

- Sum over select line numbers\
```sed -n '9,16p' file.txt | awk '{ s += $4} END { printf("%.2f\n", s) }'```
