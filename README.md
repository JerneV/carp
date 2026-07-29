# Carp

For those "Oh Crap!" moments where you mistyped. 🎏

`carp` corrects a mistyped first subcommand using Fish's existing completions,
then runs the corrected command.

```console
> git stauts
# runs: git status
```

Carp only applies a correction when one completion is the unique closest match
within a small edit distance. It leaves ambiguous typos unchanged. To avoid
surprising changes to filenames and other values, it only examines the first
argument to a command.

Obviously, you also need some kind of shell completion for the command you are using - since Carp uses these completions to guess what you meant.

## Skip list

Some commands are a poor fit for Ccarp. If Fish completions are user-specific data rather than a fixed subcommand vocabulary, carp can "correct" a valid new value into a frequently used one — for example, `ssh server02` becoming
`ssh server01` because `server01` is in your connection history.

Carp skips correction for commands in `carp_skip_commands`. On first install,
the defaults are:

```
ssh scp sftp rsync type which command where whereis
```

Add or remove commands with:

```fish
carp_skip_add mosh cd
carp_skip_remove ssh
```

Inspect or replace the whole list directly:

```fish
echo $carp_skip_commands
set -U carp_skip_commands ssh type which
```

The list is stored as a universal variable, so changes persist across
sessions.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install jernev/carp
```

Carp binds the `enter` key. On uninstall, it removes that binding and Fish falls
back to its preset Enter binding.

## Requirements

- Fish 3.4 or newer
- [Fisher](https://github.com/jorgebucaran/fisher)



## LICENSE

[MIT](LICENSE)
