#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
	pactl  get-sink-volume @DEFAULT_SINK@  | head -n 1 | cut -d'/' -f2 | tr -dc '0-9'
	
}

function get_volume_bar {
    volume=$1
    let "num_bars=volume/10" 
    let "num_spaces=10-num_bars"
    echo $num_bars >> blah
    echo $num_spaces >> blah
    if [[ $num_bars -gt 0 ]]; then
        first=$(echo $( printf -- '#%.0s' $(seq 1 $num_bars) ))
    fi

    if [[ $num_spaces -gt 0 ]]; then
        second=$( echo $( printf -- '_%.0s' $(seq 1 $num_spaces) ) ) 
    fi
    vol_bar="[$first$second]"
    echo $vol_bar

}

function control_volume {
    volume=`get_volume`
    DIR=`dirname "$0"`

    pactl set-sink-mute @DEFAULT_SINK@ 0

    if [[ $1 == "up" && "$volume" -lt "100" ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ +10%
    elif [[ $1 == "down" && "$volume" -gt "0" ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ -10%
    fi
    bar=`get_volume_bar $volume` 
    dunstify -h string:x-dunst-stack-tag:test volume $bar
}
function mute {
    DIR=`dirname "$0"`
    volume=`get_volume`
    vol_bar=`get_volume_bar $volume`

    pactl set-sink-mute @DEFAULT_SINK@ toggle
    is_muted=$([[ $(pactl get-sink-mute @DEFAULT_SINK@) == "Mute: yes" ]] && echo "Muted" || echo $vol_bar)
    dunstify -h string:x-dunst-stack-tag:test volume $is_muted
}

case $1 in
    up)
    control_volume "up"
	;;
    down)
    control_volume "down"
	;;
    mute)
    mute
esac
