# Contents

 - [General](#general)
 - [Scoop instalation](#scoop-instalation)
 - [Micro instalation](#micro-instalation)
 - [fzf instalation](#fzf-instalation)
 - [PowerShell setup](#powershell-setup)
   - [Fnuctions](#functions)
   - [Aliases](#aliases)
   - [EDITOR variable](#editor-variable)
   - [PROFILE](#profile)
 - [Web browser](#web-browser)


 

# General information 

For working with Python, a tool environment will be prepared to facilitate work using the keyboard:
- scoop: a program manager supporting open source
- micro: a console text editor
- setting environment variables, aliases and functions


Clone this repository to your computer:
- start terminal
- go (create) to the folder where you want to put the repository
- `git clone ...` - clone the repository




# For Windows

## Scoop instalation

From [Scoop](https://scoop.sh/#/):
 >- a command-line installer for Windows.
 >- Open a PowerShell terminal (version 5.1 or later) and from the PS C:\> prompt, run:

 ```
 Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
 Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
 ```


## Micro instalation

From [micro web](https://micro-editor.github.io/):
>a modern and intuitive terminal-based text editor

In the PowerShell terminal, type:
```
scoop install micro
```

If you really don't want to learn micro you can use any other text editor e.g. [Nnotepad++](https://notepad-plus-plus.org/).



## fzf instalation

From [fzf github](https://github.com/junegunn/fzf):
>- Warp, the intelligent terminal for developers
>- Available for MacOS, Linux, & Windows
>- fzf is a general-purpose command-line fuzzy finder

In the PowerShell terminal, type:
```
scoop install fzf
```


## PowerShell setup

The solutions in this section are intended for Windows users with a PowerShell terminal. Commands are executed in the
terminal or saved to a special configuration file, the location of which is set in the `$PROFILE` environment variable.

**Exception**:
>`$EDITOR` - this variable must be set in each operating system.


### PROFILE

`$PROFILE`: A PowerShell system variable that stores the path to the user's profile file. This is a script that is
automatically executed when PowerShell starts. In the PowerShell terminal:

1. `echo $PROFILE`: this will show you the location of the PowerShell configuration file eg.:
`C:\Users\test1\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
2. `dir Documents`: this will show if there is a folder `WindowsPowerShell` in the `Documents` directory:
 - `mkdir .\Documents\WindowsPowerShell`: use this command to create directory `WindowsPowerShell` if it does not exist
3. `micro $PROFILE`: editor will open/create the file for editing


### EDITOR variable

`$EDITOR`: An environment variable that indicates the default text editor used in the terminal. Many programs can use
this variable, such as Git, VS Code, ipython, etc. In the `$PROFILE` file add the following entry:

```
$EDITOR = "micro"
```


---

## Aliases

For frequently executed commands, you can define shortcuts, so-called aliases, which speed up work, e.g.:

```micro $PROFILE
Set-Alias mc micro
```
- this allows you to launch the micro editor by typing 2 characters `mc`.


## Fnuctions

1. Searching for files using fzf:




# Micro Help

1. Link to [Default Keys](https://github.com/zyedidia/micro/blob/master/runtime/help/defaultkeys.md)
2. In the opened editor, enter:
  - `<ctr> + e`: open a command prompt for running commands
  - `Tab`: In command prompt, it will autocomplete if possible.
  - In command prompt: `help defa + Tab --> help defaultkeys` - will display help on defined keyboard shortcuts
3. Basic shortcuts:
  - `<ctr> + q`: close current file (quits micro if this is the last file open)
  - `<ctr> + o`: open a file (prompts for filename)
  - `<ctr> + s`: save current file.

# Web browser

To view rendered `markdown` files, you may find useful browser extensions:

  1. Google Chrome: Markdown Viewer
  2. Mozilla Firefox: Markdown Viewer
  3. Microsoft Edge: Markdown Preview
  4. Safari: QLMarkdown





The scripts define environmental variables, e.g. `$ editor` and functions for viewing files and directors.

Dependence:
1. Windows:
- Scoop - xxx
- micro
- FZF

2. Linux:
- FZF
- any editor working in the terminal, e.g. VIM/Nvim, Nano, Micro


# Windows


File `profile.ps1` - `PowerShell` configuration:
- start Terminal (`PowerShell`)
- `echo $ profile`: display the path to the configuration file
- check if there is a catalog specified in `$PROFILE`a - if not create it, for example: `mkdir Documents \ catalog_name`
- download the file from the repository and copy it to the place specified by `$PROFILE`:` cp profile.sp1 $PROFILE`
- restart `PowerShell`


# Linux

On Linux:
 - edit your `~/.bashrc` (or `~./profile`) file
 - add line: `export EDITOR=micro`
