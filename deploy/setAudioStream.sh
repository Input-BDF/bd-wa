#!/usr/bin/env bash
echo "replace Stream url"

declare -A STREAM_DAY_URLS
declare -A STREAM_NIGHT_URLS
declare STREAM_URL
TZ=Europe/Berlin
export TZ
DOW=$(date +%u)

STREAM_DAY_URLS[1]="https://stream.radioparadise.com/mp3-128"
STREAM_NIGHT_URLS[1]="https://streams.radiobob.de/100/mp3-192/streams.radiobob.de/"
STREAM_DAY_URLS[2]="https://stream.radioparadise.com/mp3-128"
STREAM_NIGHT_URLS[2]="https://br-puls-live.cast.addradio.de/br/puls/live/mp3/mid"
STREAM_DAY_URLS[3]="https://stream.radioparadise.com/mp3-128"
STREAM_NIGHT_URLS[3]="https://streams.starfm.de/hot_top.mp3"
STREAM_DAY_URLS[4]="https://stream.radioparadise.com/mp3-128"
STREAM_NIGHT_URLS[4]="https://streams.starfm.de/millennium_rock.mp3"
STREAM_DAY_URLS[5]="https://stream.radioparadise.com/mp3-128"
STREAM_NIGHT_URLS[5]="https://fm4.stream.laut.fm/fm4"
STREAM_DAY_URLS[6]="https://stream.radioparadise.com/mp3-128"
STREAM_NIGHT_URLS[6]="https://fm4.stream.laut.fm/fm4"
STREAM_DAY_URLS[7]="https://stream.radioparadise.com/mp3-128"
STREAM_NIGHT_URLS[7]="https://mp3.ffh.de/ffhchannels/hqsoundtrack.mp3"

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
