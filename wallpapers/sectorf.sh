#!/usr/bin/env bash
# wallpaper.sh  WIDTH  HEIGHT  LOGO.png  [OUTPUT.png]  [TEXT]  [FONT]  [PTS]  [GAP]
# Example:
#   ./wallpaper.sh 3440 1920 logo.png sector-f-wall.png "sector-f-labs" "DejaVuSansMono" 140 50

# --- user-supplied args with sane fallbacks --------------------------------
BG_W=${1:-3440}
BG_H=${2:-1920}
LOGO=${3:-logo-nocircle.png}
OUT=${4:-sector-f-labs.png}

TEXT=${5:-"Sector F Labs"}      # what to write
FONT=${6:-"FreeMono"}     # any installed mono font
PTS=${7:-120}                   # point size
GAP=${8:-150}                    # gap between logo & text (px)

# --- derive logo geometry --------------------------------------------------
read LOGO_W LOGO_H < <(identify -format "%w %h" "$LOGO")

# manual offset that puts *logo* a tad left of centre
OFF_X=${OFF_X:--750}
OFF_Y=${OFF_Y:=0}

# --- build a transparent label for the text --------------------------------
TMP_TXT=$(mktemp --suffix=.png)
convert -background none \
        -fill "#e77500" -font "$FONT" -pointsize "$PTS" \
        label:"$TEXT" "$TMP_TXT"

read TEXT_W TEXT_H < <(identify -format "%w %h" "$TMP_TXT")

# offset that puts the *text* directly to the right of the logo
# centre of text = centre of logo + ½logo + GAP + ½text
TXT_OFF_X=$(( OFF_X + LOGO_W/2 + GAP + TEXT_W/2 ))
TXT_OFF_Y=$OFF_Y   # same vertical alignment

# --- assemble the wallpaper -------------------------------------------------
magick -size "${BG_W}x${BG_H}" xc:black \
       \( "$LOGO" -negate -alpha set -channel A -evaluate multiply 0.75 \) \
       -gravity center -geometry +${OFF_X}+${OFF_Y} -composite \
       \( "$TMP_TXT" \) \
       -gravity center -geometry +${TXT_OFF_X}+${TXT_OFF_Y} -composite \
       "$OUT"

rm -f "$TMP_TXT"
echo "🎉  Wallpaper saved to: $OUT"
