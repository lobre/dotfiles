declare-user-mode buffers

define-command map-buffer-to -params 1 %{
    map global buffers %arg{1} ":buffer %val{buffile}<ret>" -docstring "%val{bufname}"
}

define-command -hidden refresh-buffer-picker-maps %{
    evaluate-commands %sh{
        kakquote() {
            printf "%s" "$*" | sed "s/'/''/g; 1s/^/'/; \$s/\$/'/"
        }

        keys="a s d f g"

        for key in $keys; do
            printf 'unmap global buffers %s\n' "$key"
        done

        eval set -- "$kak_quoted_buflist"

        for key in $keys; do
            while [ $# -gt 0 ]; do
                buffer="$1"
                shift

                [ "$buffer" = "$kak_bufname" ] && continue
                [ "$buffer" = "*debug*" ] && continue

                rhs=":buffer $(kakquote "$buffer")<ret>"

                printf 'map global buffers %s %s -docstring %s\n' \
                    "$key" \
                    "$(kakquote "$rhs")" \
                    "$(kakquote "$buffer")"

                break
            done
        done
    }
}

hook global WinDisplay .* %{
    arrange-buffers %val{bufname}
    refresh-buffer-picker-maps
}

map global buffers <space> "<esc>:buffer<space>" -docstring 'search for buffer'
