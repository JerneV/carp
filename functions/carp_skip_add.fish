function carp_skip_add --description 'Add commands to the carp skip list'
    if test (count $argv) -eq 0
        echo "Usage: carp_skip_add COMMAND ..." >&2
        return 1
    end

    for token in $argv
        set -l cmd "$token"
        if string match --quiet -- '/*' "$token"
            set cmd (path basename "$token")
        end

        if not contains -- "$cmd" $carp_skip_commands
            set -U carp_skip_commands $carp_skip_commands "$cmd"
        end
    end
end
