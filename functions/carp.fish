function carp --description 'Correct a mistyped subcommand and execute the command line'
    set -l typo (commandline --current-token)
    set -l prefix (commandline --cut-at-cursor --tokens-expanded --current-process)

    # Only touch the first argument. Correcting later completion candidates could
    # silently rename filenames, revisions, or other user data.
    if test (count $prefix) -eq 1; and test -n "$typo"
        set -l correction (_carp_suggestion "$typo" $prefix)
        if test $status -eq 0
            commandline --replace --current-token "$correction"
        end
    end

    commandline --function execute
end
