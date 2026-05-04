# “Four colors should be more than enough for any interface.”
#
# https://wiki.xxiivv.com/site/theme.html
# https://en.wikipedia.org/wiki/Four_color_theorem
#
# But anyway, I will use more.

evaluate-commands %sh{
    white='rgb:ffffff'
    black='rgb:073642'

    grayLight='rgb:e9edf2'
    grayMedium='rgb:dde2e8'
    grayDim='rgb:97aabd'

    accent='rgb:77ddbb'

    error='rgb:ef4444'
    warning='rgb:d97706'

    echo "
        set-face global Default ${black},${white}
    "

    # cursors and selections
    echo "
        set-face global PrimarySelection   ${black},${accent}+fg
        set-face global SecondarySelection ${black},${grayMedium}+fg

        set-face global PrimaryCursor      ${white},${black}+fg
        set-face global PrimaryCursorEol   ${white},${black}+fg
        set-face global SecondaryCursor    ${black},${grayDim}+fg
        set-face global SecondaryCursorEol ${black},${grayDim}+fg
    "

    echo "
        set-face global MenuForeground  ${white},${black}
        set-face global MenuBackground  ${black},${grayLight}
        set-face global MenuInfo        ${grayDim}
        set-face global StatusLine      MenuBackground
        set-face global StatusLineMode  ${black}+b
        set-face global StatusLineInfo  ${black}+b
        set-face global StatusLineValue ${black}+b
        set-face global StatusCursor    ${white},${black}
        set-face global Prompt          ${black}

        set-face global Information       default
        set-face global InlineInformation MenuBackground
        set-face global Error             default,${error}

        set-face global DiagnosticError   ${error}+u
        set-face global DiagnosticWarning ${warning}+u

        set-face global BufferPadding ${grayDim}

        set-face global MatchingChar     default+u
        set-face global Whitespace       default
        set-face global WhitespaceIndent default
        set-face global WrapMarker       default
    "

    # line numbers
    echo "
        set-face global LineNumbers        ${grayDim}
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

        set-face global comment ${grayDim}

        set-face global builtin +b
        set-face global meta +b
        set-face global keyword +b
    "

    # reset colored faces from lsp and colorize errors
    echo "
        set-face global InlayDiagnosticError      ${error}
        set-face global InlayDiagnosticWarning    ${warning}

        set-face global LineFlagError             ${error}
        set-face global LineFlagWarning           ${warning}

        set-face global InlayHint                 default
        set-face global InlayCodeLens             default

        set-face global SnippetsNextPlaceholders  default
        set-face global SnippetsOtherPlaceholders default

        set-face global InfoDefault default
    "
}
