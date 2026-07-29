function _carp_skip_command --description 'Return 0 when carp should not correct this command'
    set -l cmd $argv[1]

    if test -z "$cmd"
        return 1
    end

    if string match --quiet -- '/*' "$cmd"
        set cmd (path basename "$cmd")
    end

    contains -- "$cmd" $carp_skip_commands
end
