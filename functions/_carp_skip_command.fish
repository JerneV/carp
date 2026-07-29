function _carp_skip_command --description 'Return 0 when carp should not correct this command'
    # Skip commands where Fish completions are user-specific data rather than a fixed
    # vocabulary. (Like `ssh`ing to a new host.)
    #
    # Also skip shell builtins which iterate over thousands of options - like `which` or `type`.
    set -l cmd $argv[1]

    if test -z "$cmd"
        return 1
    end

    # Just get the command; drop the path.
    if string match --quiet -- '/*' "$cmd"
        set cmd (path basename "$cmd")
    end

    switch $cmd
        case ssh scp sftp rsync
            return 0
        case type which command where whereis
            return 0
    end

    return 1
end
