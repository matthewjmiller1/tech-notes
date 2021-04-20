# Linux Commands

## Bash
- Print commands as they are executed
```set -x```

- Using basename with xargs
```ls | xargs -I % sh -c 'mv % new_path/$(basename %)'```
