#!/bin/bash
TYPE=$1 # sink hoặc source
DEFAULT_DEV="@DEFAULT_SINK@"
[ "$TYPE" = "source" ] && DEFAULT_DEV="@DEFAULT_SOURCE@"

# Lấy trạng thái Mute
IS_MUTED=$(pactl get-${TYPE}-mute $DEFAULT_DEV 2>/dev/null | grep -q "yes" && echo "1" || echo "0")

# Lấy tên Port in hoa
PORT_NAME=$(pactl list ${TYPE}s 2>/dev/null | grep "Active Port:" | cut -d'-' -f3- | xargs | tr '[:lower:]' '[:upper:]')
[ -z "$PORT_NAME" ] && PORT_NAME="UNKNOWN"

# Cắt ngắn nếu quá dài
PORT_SHORT=$(echo "$PORT_NAME" | cut -c1-18)

# Lấy % Volume
VOL=$(pactl get-${TYPE}-volume $DEFAULT_DEV 2>/dev/null | head -n1 | awk '{print $5}')

if [ "$IS_MUTED" = "1" ]; then
    echo "\${color #557799}${PORT_SHORT}\${alignr}MUTE"
else
    echo "\${color #00f0ff}${PORT_SHORT}\${alignr}${VOL}"
fi
