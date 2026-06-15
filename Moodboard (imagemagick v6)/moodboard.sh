#!/bin/bash

# Use:
# ./moodboard.sh columns rows

# MoodBoard v1.0.0 by Matias H. Castillo

shopt -s nullglob

COLS=$1
ROWS=$2
OUTPUT="./Output/moodboard.jpg"

# Thumbnails size
THUMB_W=240
THUMB_H=135

# Spacing
SPACE=12

# Final image sizes
FINAL_W=$(((THUMB_W * (COLS)) + (SPACE * (COLS)) + (SPACE * 8)))
FINAL_H=$(((THUMB_H * (ROWS + 1)) + (SPACE * (ROWS))))

# Validation
if [ -z "$COLS" ] || [ -z "$ROWS" ]; then
    echo "Use: ./moodboard.sh columns rows"
    exit 1
fi

TOTAL=$((COLS * ROWS))

mkdir -p .moodtemp

echo "Generating collage..."

montage $(printf "%s\n" *.jpeg *.jpg *.png *.webp 2>/dev/null | shuf -n $TOTAL) \
-tile ${COLS}x${ROWS} \
-geometry ${THUMB_W}x${THUMB_H}+${SPACE}+${SPACE} \
-background none \
-bordercolor "#ffffff40" \
-border 1 \
-alpha on \
png:- | convert - -trim +repage .moodtemp/collage.png

echo "Generating ambient background..."

convert .moodtemp/collage.png \
-resize ${FINAL_W}x${FINAL_H}^ \
-gravity center \
-extent ${FINAL_W}x${FINAL_H} \
-blur 0x38 \
-brightness-contrast -30x-12 \
-modulate 100,125,100 \
-colorize 5,0,10 \
.moodtemp/background.png

echo "Composing output image..."

mkdir -p Output

convert .moodtemp/background.png \
\( .moodtemp/collage.png \
   \( +clone -background black -shadow 80x10+0+8 \) \
   +swap \
   -background none \
   -layers merge \
\) \
-gravity center \
-composite \
-background "#111111" \
-alpha remove \
-alpha off \
-strip \
-quality 90 \
"$OUTPUT"

echo "Ready: $OUTPUT"
