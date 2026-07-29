function carp --description 'Correct a mistyped subcommand and execute the command line'
    set -l typo (commandline --current-token)
    set -l prefix (commandline --cut-at-cursor --tokens-expanded --current-process)

    # Only touch the first argument. Skip commands whose completions are
    # user-specific data (hosts, paths) or too slow to query (type, which).
    if test (count $prefix) -eq 1; and test -n "$typo"; and not _carp_skip_command "$prefix[1]"
        set -l correction (_carp_suggestion "$typo" $prefix)
        if test $status -eq 0
            commandline --replace --current-token "$correction"
        end
    end

    commandline --function execute
end
