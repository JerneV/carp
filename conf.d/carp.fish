# Carp default skip commands.
if not set -q carp_skip_commands
    set -Ux carp_skip_commands ssh scp sftp rsync type which command where whereis
end

function _carp_bind
    for mode in insert default
        bind --user --mode $mode enter carp
    end
end

function _carp_unbind
    for mode in insert default
        set -l binding (bind --user --mode $mode enter 2>/dev/null)
        if string match --quiet -- '* carp' "$binding"
            bind --erase --user --mode $mode enter
        end
    end
end

function _carp_install --on-event carp_install
    _carp_bind
end

function _carp_update --on-event carp_update
    _carp_bind
end

function _carp_uninstall --on-event carp_uninstall
    _carp_unbind
    functions --erase carp _carp_suggestion _carp_skip_command carp_skip_add carp_skip_remove
    functions --erase _carp_bind _carp_unbind _carp_install _carp_update _carp_uninstall
    set --erase carp_skip_commands
end

_carp_bind
