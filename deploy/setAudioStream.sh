#!/usr/bin/env bash
echo "replace Stream url"

declare -A STREAM_DAY_URLS
declare -A STREAM_NIGHT_URLS
declare STREAM_URL
TZ=Europe/Berlin
export TZ
DOW=$(date +%u)

STREAM_DAY_URLS[1]="https://lagunas-no-copyright-music.stream.laut.fm/lagunas-no-copyright-music"
STREAM_NIGHT_URLS[1]="https://hyperadio-nocopyright.stream.laut.fm/hyperadio-nocopyright"
STREAM_DAY_URLS[2]="https://lagunas-no-copyright-music.stream.laut.fm/lagunas-no-copyright-music"
STREAM_NIGHT_URLS[2]="https://hyperadio-nocopyright.stream.laut.fm/hyperadio-nocopyright"
STREAM_DAY_URLS[3]="https://lagunas-no-copyright-music.stream.laut.fm/lagunas-no-copyright-music"
STREAM_NIGHT_URLS[3]="https://hyperadio-nocopyright.stream.laut.fm/hyperadio-nocopyright"
STREAM_DAY_URLS[4]="https://lagunas-no-copyright-music.stream.laut.fm/lagunas-no-copyright-music"
STREAM_NIGHT_URLS[4]="https://hyperadio-nocopyright.stream.laut.fm/hyperadio-nocopyright"
STREAM_DAY_URLS[5]="https://lagunas-no-copyright-music.stream.laut.fm/lagunas-no-copyright-music"
STREAM_NIGHT_URLS[5]="https://hyperadio-nocopyright.stream.laut.fm/hyperadio-nocopyright"
STREAM_DAY_URLS[6]="https://lagunas-no-copyright-music.stream.laut.fm/lagunas-no-copyright-music"
STREAM_NIGHT_URLS[6]="https://hyperadio-nocopyright.stream.laut.fm/hyperadio-nocopyright"
STREAM_DAY_URLS[7]="https://lagunas-no-copyright-music.stream.laut.fm/lagunas-no-copyright-music"
STREAM_NIGHT_URLS[7]="https://hyperadio-nocopyright.stream.laut.fm/hyperadio-nocopyright"

PLACEHOLDER="--streamurl--"

function isDayOrNight {
 local hod
 hod=$(date +%H)
 hod=${hod#0}
 if((hod >= 18 && hod <= 24 || hod >= 0 && hod < 7)); then
    echo 'Night'
 else
    echo 'Day'
 fi      
}


MODE=$(isDayOrNight)
echo "Mode: $MODE"
echo "Day of Week: ${DOW}"
echo "Hour of day: $(date +%H)"
case $MODE in
     'Night')
     STREAM_URL=$(sed 's|/|\\/|g' <<< ${STREAM_NIGHT_URLS[$DOW]})
     ;;
     'Day')
     STREAM_URL=$(sed 's|/|\\/|g' <<< ${STREAM_DAY_URLS[$DOW]})
     ;;
esac
echo "Stream URL: $STREAM_URL"


sed -i  "s/$PLACEHOLDER/$STREAM_URL/g" ./*.json
