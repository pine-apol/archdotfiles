#!/bin/bash

# Function to get CPU usage percentage
cpu_usage() {
    local usage
    usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo " ${usage}%"
}

# Function to get RAM usage percentage
ram_usage() {
    local total_used
    total_used=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo " ${total_used}%"
}

# Function to get audio volume
audio_volume() {
    local volume
    local muted
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$muted" = "yes" ]; then
        echo " Muted"
    else
        echo " ${volume}"
    fi
}

# Display the status
echo "$(audio_volume) | $(cpu_usage) | $(ram_usage)"

