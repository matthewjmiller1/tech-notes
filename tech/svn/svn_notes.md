# subversion Notes

## Commands
- Show SVN commits for a given user ("bz")
    ```
    svn log | sed -n '/\<bz\>/,/-----$/ p'
    ```
