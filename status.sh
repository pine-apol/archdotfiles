#!/bin/bash

# Function to get network RX transfer speed
get_network_speed() {
    local iface="eth0"  # Change this to your network interface name (e.g., wlan0, enp3s0)
    local rx_bytes_1=$(cat /sys/class/net/$iface/statistics/rx_bytes)
    sleep 1
    local rx_bytes_2=$(cat /sys/class/net/$iface/statistics/rx_bytes)
    local rx_speed=$(( ($rx_bytes_2 - $rx_bytes_1) / 1024 ))  # Convert to KB/s
    echo " ${rx_speed}K"  #  is the icon for network speed; change as needed
}

# Function to get volume level
get_volume_level() {
    local volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
    local muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$muted" = "yes" ]; then
        echo " Muted"  #  is the icon for volume; change as needed
    else
        echo " $volume"  #  is the icon for volume; change as needed
    fi
}

# Function to get CPU usage percentage
get_cpu_usage() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo " ${cpu_usage}%"  #  is the icon for CPU usage; change as needed
}

# Function to get RAM usage percentage
get_ram_usage() {
    local ram_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    local ram_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
    local ram_used=$((ram_total - ram_free))
    local ram_usage=$(( (ram_used * 100) / ram_total ))
    echo " ${ram_usage}%"  #  is the icon for RAM usage; change as needed
}

# Output all the metrics in one line for dwmblocks
echo "$(get_network_speed) | $(get_volume_level) | $(get_cpu_usage) | $(get_ram_usage)"

