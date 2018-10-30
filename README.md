# shell-configs
Configuration files for various shells

## Microsoft.PowerShell_profile.ps1
Mimics a few common linux commands, adds a few helpers, and shows current Git branch.
To use, place file in the `%USERPROFILE%\Documents\WindowsPowerShell\` directory, or enter `ise $PROFILE.CurrentUserAllHosts` at the prompt and copy and paste the code into the file.

### Linux-like
* **`ls [<PATH>]`**
* **`ll [<PATH>]`** Similar to `ls -l`
* **`env`**
* **`cd <PATH>`** Aliased to store working directory in `$OLDPWD` environment variable before changing working directory
* **`cd-`** Changes directory to previous working directory. Similar to `cd -`
* **`edit <FILE>`** Opens file in Notepad
* **`touch <FILE>`** Updates file's last write time, or creates empty file

### Helpers
* **`smite <PATH>`** Recursively deletes directory and its contents
* **`func <FUNCTION_NAME>`** Displays definition of passed function
* **`editprofile`** Opens this configuration file in Windows PowerShell ISE

### Prompt
```
<USERNAME>@<COMPUTERNAME> (<CURRENT_WORKING_DIRECTORY>) [<GITBRANCH>]
PS>
```
The Git branch is determined by:
1) Looking for a `.git` directory in current directory
2) If found, saves the current directory to the `$gitRoot` environment variable
3) Sets `<GITBRANCH>` to the value in `$.gitRoot/.git/HEAD`. This value is sticky while in `$gitRoot` subdirectories
