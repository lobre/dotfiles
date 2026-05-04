# Named after Phoenix: a flat, low-rise city with strong sunlight and uniform, grid-like structure
#
# “Four colors should be more than enough for any interface.”
#
# https://wiki.xxiivv.com/site/theme.html
# https://en.wikipedia.org/wiki/Four_color_theorem
#
# But anyway, I will use more.
#
# Color system constraints:
#
# - white / black are the base anchors:
#   * white is the main background and light text when needed
#   * black is the primary text color and used for strong active states
#
# - accent is used for the main selection background
#
# - Two close background layers:
#   * layerTop is used for surfaces (menus / dropdowns)
#   * layerBottom is used for selections
#   * they must be distinguishable when adjacent
#   * layerTop must be distinct from white
#
# - dim is a multi-purpose subdued color:
#   * foreground: comments, line numbers, secondary text
#   * background: secondary cursor
#   * must be readable on white and on layerTop
#   * must remain visually weaker than black text and accent
#
# - Layering (bottom to top):
#   white (background) → layerBottom (selections) → layerTop (menus / dropdowns)
#
# - Luminance order:
#   white > layerTop > layerBottom
#
# - Note on luminance vs layering (city metaphor):
#   * background is a large flat ground, fully exposed to light
#   * selections (layerBottom) are like small, irregular buildings on the ground
#     with angles, edges, and details → they catch less light → slightly darker
#   * menus (layerTop) are like large flat clouds above the city
#     smooth and facing the light directly → they reflect more light → lighter
#   * this also ensures good contrast for dim text inside menus
#
evaluate-commands %sh{
    hsl() {
        awk -v h="$1" -v s="$2" -v l="$3" '
        function hue2rgb(p, q, t) {
            if (t < 0) t += 1
            if (t > 1) t -= 1
            if (t < 1/6) return p + (q - p) * 6 * t
            if (t < 1/2) return q
            if (t < 2/3) return p + (q - p) * (2/3 - t) * 6
            return p
        }

        BEGIN {
            h = h % 360
            if (h < 0) h += 360
            h /= 360

            s /= 100
            l /= 100

            if (s == 0) {
                r = g = b = l
            } else {
                q = (l < 0.5) ? l * (1 + s) : l + s - l * s
                p = 2 * l - q
                r = hue2rgb(p, q, h + 1/3)
                g = hue2rgb(p, q, h)
                b = hue2rgb(p, q, h - 1/3)
            }

            printf "rgb:%02x%02x%02x\n", int(r * 255 + 0.5), int(g * 255 + 0.5), int(b * 255 + 0.5)
        }'
    }

    hue=196

    white=$(hsl 0 0 100)
    black=$(hsl "$hue" 81 14)

    layerTop=$(hsl "$hue" 24 93)
    layerBottom=$(hsl "$hue" 24 90)
    dim=$(hsl "$hue" 19 64)

    accent=$(hsl 158 60 67)
    error=$(hsl 0 84 60)
    warning=$(hsl 28 89 45)

    echo "
        set-face global Default ${black},${white}
    "

    # cursors and selections
    echo "
        set-face global PrimarySelection   ${black},${accent}+fg
        set-face global SecondarySelection ${black},${layerBottom}+fg

        set-face global PrimaryCursor      ${white},${black}+fg
        set-face global PrimaryCursorEol   ${white},${black}+fg
        set-face global SecondaryCursor    ${black},${dim}+fg
        set-face global SecondaryCursorEol ${black},${dim}+fg
    "

    echo "
        set-face global MenuForeground  ${white},${black}
        set-face global MenuBackground  ${black},${layerTop}
        set-face global MenuInfo        ${dim}
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

    # reset colored faces from lsp
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
