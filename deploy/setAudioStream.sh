#!/usr/bin/env bash
echo "replace Stream url"

declare -A STREAM_DAY_URLS
declare -A STREAM_NIGHT_URLS
declare STREAM_URL
TZ=Europe/Berlin
export TZ
DOW=$(date +%u)

STREAM_DAY_URLS[1]="http://stream.zeno.fm/1q67s9mt6mzuv"
STREAM_NIGHT_URLS[1]="http://stream.zeno.fm/3dee7zszxwzuv"
STREAM_DAY_URLS[2]="http://stream.zeno.fm/1q67s9mt6mzuv"
STREAM_NIGHT_URLS[2]="http://stream.zeno.fm/3dee7zszxwzuv"
STREAM_DAY_URLS[3]="http://stream.zeno.fm/1q67s9mt6mzuv"
STREAM_NIGHT_URLS[3]="http://stream.zeno.fm/3dee7zszxwzuv"
STREAM_DAY_URLS[4]="http://stream.zeno.fm/1q67s9mt6mzuv"
STREAM_NIGHT_URLS[4]="http://stream.zeno.fm/3dee7zszxwzuv"
STREAM_DAY_URLS[5]="http://stream.zeno.fm/1q67s9mt6mzuv"
STREAM_NIGHT_URLS[5]="http://stream.zeno.fm/3dee7zszxwzuv"
STREAM_DAY_URLS[6]="http://stream.zeno.fm/1q67s9mt6mzuv"
STREAM_NIGHT_URLS[6]="http://stream.zeno.fm/3dee7zszxwzuv"
STREAM_DAY_URLS[7]="http://stream.zeno.fm/1q67s9mt6mzuv"
STREAM_NIGHT_URLS[7]="http://stream.zeno.fm/3dee7zszxwzuv"

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
