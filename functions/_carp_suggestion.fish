function _carp_suggestion --description 'Find one unambiguous correction from Fish completions'
    set -l typo $argv[1]
    set -e argv[1]

    if test -z "$typo"; or test (count $argv) -eq 0
        return 1
    end

    set -l escaped_prefix
    for token in $argv
        set -a escaped_prefix (string escape -- "$token")
    end
    set -l completion_query (string join ' ' -- $escaped_prefix)' '

    set -l candidates
    for completion in (complete -C "$completion_query")
        set -l candidate (string split --max 1 \t -- "$completion")[1]

        if test -z "$candidate"; or string match --quiet -- '-*' "$candidate"
            continue
        end
        if test "$candidate" = "$typo"
            return 1
        end

        if not contains -- "$candidate" $candidates
            set -a candidates "$candidate"
        end
    end

    if test (count $candidates) -eq 0
        return 1
    end

    # Build one regex for every string one edit away from the typo. Matching
    # all candidates once is much faster in Fish than calculating a distance
    # matrix separately for every completion.
    set -l patterns
    set -l typo_length (string length -- "$typo")

    for position in (seq 0 $typo_length)
        set -l prefix ''
        set -l suffix ''
        if test $position -gt 0
            set prefix (string escape --style=regex -- (string sub --start 1 --length $position -- "$typo"))
        end
        if test $position -lt $typo_length
            set suffix (string escape --style=regex -- (string sub --start (math "$position + 1") -- "$typo"))
        end

        # One character inserted into the completion.
        set -a patterns "$prefix.$suffix"
    end

    for position in (seq $typo_length)
        set -l prefix ''
        set -l suffix ''
        if test $position -gt 1
            set prefix (string escape --style=regex -- (string sub --start 1 --length (math "$position - 1") -- "$typo"))
        end
        if test $position -lt $typo_length
            set suffix (string escape --style=regex -- (string sub --start (math "$position + 1") -- "$typo"))
        end

        # One deletion or substitution.
        set -a patterns "$prefix$suffix" "$prefix.$suffix"

        # One adjacent transposition.
        if test $position -lt $typo_length
            set -l left (string escape --style=regex -- (string sub --start $position --length 1 -- "$typo"))
            set -l right (string escape --style=regex -- (string sub --start (math "$position + 1") --length 1 -- "$typo"))
            set -a patterns "$prefix$right$left"(string escape --style=regex -- (string sub --start (math "$position + 2") -- "$typo"))
        end
    end

    set -l pattern '^(?:'(string join '|' -- $patterns)')$'
    set -l matches (string match --regex --entire -- "$pattern" $candidates)

    if test (count $matches) -eq 1
        echo "$matches[1]"
        return 0
    end

    return 1
end
