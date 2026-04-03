# “Four colors should be more than enough for any interface.”
#
# https://wiki.xxiivv.com/site/theme.html
# https://en.wikipedia.org/wiki/Four_color_theorem
#
# But anyway, I will use five.

evaluate-commands %sh{
    white='rgb:ffffff'
    black='rgb:000000'
    accent='rgb:77ddbb'
    alert='rgb:ff6622'
    dim='rgb:909090'

    # example for block of faces
    echo "
        set-face global PrimaryCursor      ${white},${black}+fg
        set-face global PrimaryCursorEol   ${white},${black}+fg
        set-face global PrimarySelection   ${black},${accent}+fg
        set-face global SecondarySelection ${black},${dim}+fg
        set-face global SecondaryCursor    ${black},${dim}+fg
        set-face global SecondaryCursorEol ${black},${dim}+fg
    "

    echo "
        set-face global MenuForeground  ${white},${black}
        set-face global MenuBackground  ${black},${accent}
        set-face global MenuInfo        ${dim}
        set-face global StatusLine      MenuBackground
        set-face global StatusLineMode  ${black}+b
        set-face global StatusLineInfo  ${black}+b
        set-face global StatusLineValue ${black}+b
        set-face global StatusCursor    PrimaryCursor
        set-face global Prompt          ${black}

        set-face global Information       default
        set-face global InlineInformation MenuBackground
        set-face global Error             default,${alert}

        set-face global DiagnosticError   ${alert}+u
        set-face global DiagnosticWarning default+u

        set-face global BufferPadding ${dim}

        set-face global MatchingChar     default+u
        set-face global Whitespace       default
        set-face global WhitespaceIndent default
        set-face global WrapMarker       default
    "

    # line numbers
    echo "
        set-face global LineNumbers        ${dim}
        set-face global LineNumberCursor   LineNumbers
        set-face global LineNumbersWrapped LineNumbers

        hook global ModeChange push:.*:insert %{
            set-face global LineNumberCursor ${black}+b
        }

        hook global ModeChange pop:insert:.* %{
            set-face global LineNumberCursor LineNumbers
        }
    "

    # reset colors defined in default.kak and used in rc
    echo "
        unset-face global value
        unset-face global type
        unset-face global variable
        unset-face global module
        unset-face global function
        unset-face global string
        unset-face global keyword
        unset-face global operator
        unset-face global attribute
        unset-face global comment
        unset-face global documentation
        unset-face global meta
        unset-face global builtin

        unset-face global title
        unset-face global header
        unset-face global mono
        unset-face global block
        unset-face global link
        unset-face global bullet
        unset-face global list

        set-face global comment ${dim}

        set-face global builtin +b
        set-face global meta +b
        set-face global keyword +b
    "

    # reset colored faces from lsp and colorize errors
    echo "
        set-face global InlayDiagnosticError      ${alert}
        set-face global InlayDiagnosticWarning    default

        set-face global LineFlagError             ${alert}
        set-face global LineFlagWarning           default

        set-face global InlayHint                 default
        set-face global InlayCodeLens             default

        set-face global SnippetsNextPlaceholders  default
        set-face global SnippetsOtherPlaceholders default

        set-face global InfoDefault red,blue
    "
}
