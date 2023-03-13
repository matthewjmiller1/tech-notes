# Windows Notes

## Configuration

### Thunderbird

- [Disable updates checks for offline use](https://support.mozilla.org/en-US/questions/1269626)
    - Exit Thunderbird.
    - Type 'Run' in search and select 'Run' app
    - In 'Run' app type regedit and click on OK
    - Under `HKEY_LOCAL_MACHINE\Software\Policies`, create new subkey called
      'Mozilla': `HKEY_LOCAL_MACHINE\Software\Policies\Mozilla`
    - Then create new subkey called 'Thunderbird':
      `HKEY_LOCAL_MACHINE\Software\Policies\Mozilla\Thunderbird`
    - On the right, create a new 32-Bit DWORD value DisableAppUpdate.
        - Note: Even if you are running 64-bit Windows you must still create a
          32-bit DWORD value.
    - Set its value to 1.
    - Start Thunderbird
    - Menu icon > Options > Options > Advanced > 'Updates' tab Thunderbird
      updates It will state current version number. Options are removed and
      replaced by: 'Updates disabled by your system administrator'
    - To undo the change, remove the DisableAppUpdate 32-bit DWORD value you
      have created, then restart Thunderbird.

### Firefox

- Disable updates checks for offline use
    - In Firefox, it looks like there is an enterprise policy setting
      (DisableAppUpdate=true) that prevents this in Firefox
        - <https://github.com/mozilla/policy-templates/blob/master/README.md#disableappupdate>
        - <https://support.mozilla.org/en-US/kb/managing-firefox-updates>
