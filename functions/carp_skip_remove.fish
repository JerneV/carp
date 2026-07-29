function carp_skip_remove --description 'Remove commands from the carp skip list'
    if test (count $argv) -eq 0
        echo "Usage: carp_skip_remove COMMAND ..." >&2
        return 1
    end

    for token in $argv
        set -l cmd "$token"
        if string match --quiet -- '/*' "$token"
            set cmd (path basename "$token")
        end

        if contains -- "$cmd" $carp_skip_commands
            set -U carp_skip_commands (string match -v -- "$cmd" $carp_skip_commands)
        end
    end
end
