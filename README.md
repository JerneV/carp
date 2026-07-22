# carp

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

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher "fish plugin manager"):

```fish
fisher install jernev/carp
```
```
```


Carp binds the `enter` key. On uninstall, it removes that binding and Fish falls
back to its preset Enter binding.

## Requirements

- Fish 3.4 or newer
- [Fisher](https://github.com/jorgebucaran/fisher)

## LICENSE

[MIT](LICENSE)
