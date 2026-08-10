#!/bin/bash
OUT_FILE="/tmp/ssd_generated.conky"

cat << 'EOF_SSD' > "$OUT_FILE"
${alignc}${color #00aaff}${font FreeMono:size=22:bold}┌────────[ SSD ]────────┐${font}
${voffset 6}${alignc}${color #4db8ff}${font FreeMono:size=15:bold}NVMe SSD Partition Usage${font}
EOF_SSD

lsblk -ln -o KNNAME,FSTYPE,SIZE,MOUNTPOINT,TYPE | grep "part" | while read -r dev fstype size mountpoint type; do
    [ -z "$fstype" ] && fstype="PARTITION"
    FSTYPE_UPPER=$(echo "$fstype" | tr 'a-z' 'A-Z')

    if [ "$mountpoint" = "/" ]; then
        cat << EOF_SSD >> "$OUT_FILE"
\${voffset 6}\${offset 11}\${color #00f0ff}\${font FreeMono:size=11:bold}⚡ ACTIVE: ${FSTYPE_UPPER} Partition ( / )\${font}
\${offset 11}\${color #d0d8e0}\${font FreeMono:size=10:bold}Used: \${fs_used /} / \${fs_size /}\${alignr}\${color #00f0ff}\${fs_used_perc /}%\${font}
\${voffset 2}\${offset 11}\${color #00f0ff}\${fs_bar 10,418 /}\${font}
EOF_SSD
    elif [ "$fstype" = "swap" ] || [ "$mountpoint" = "[SWAP]" ]; then
        cat << EOF_SSD >> "$OUT_FILE"
\${voffset 4}\${offset 11}\${color #557799}\${font FreeMono:size=10:bold}SWAP Memory (${dev})\${font}
\${offset 11}\${color #88aacc}\${font FreeMono:size=10:bold}Used: \${swap} / \${swapmax}\${alignr}\${color #557799}\${swapperc}%\${font}
\${voffset 2}\${offset 11}\${color #224466}\${swapbar 6,418}\${font}
EOF_SSD
    elif [ -n "$mountpoint" ]; then
        cat << EOF_SSD >> "$OUT_FILE"
\${voffset 4}\${offset 11}\${color #557799}\${font FreeMono:size=10:bold}${FSTYPE_UPPER} Partition ( ${mountpoint} )\${font}
\${offset 11}\${color #88aacc}\${font FreeMono:size=10:bold}Used: \${fs_used ${mountpoint}} / \${fs_size ${mountpoint}}\${alignr}\${color #557799}\${fs_used_perc ${mountpoint}}%\${font}
\${voffset 2}\${offset 11}\${color #224466}\${fs_bar 6,418 ${mountpoint}}\${font}
EOF_SSD
    else
        cat << EOF_SSD >> "$OUT_FILE"
\${voffset 4}\${offset 11}\${color #557799}\${font FreeMono:size=10:bold}${FSTYPE_UPPER} Partition ( /dev/${dev} )\${font}
\${offset 11}\${color #88aacc}\${font FreeMono:size=10:bold}Size: ${size}\${alignr}\${color #557799}Unmounted\${font}
\${voffset 2}\${offset 11}\${color #224466}\${execbar echo 0}\${font}
EOF_SSD
    fi
done
