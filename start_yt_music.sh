#!/bin/bash

# Mở xfce4-terminal ở chế độ phát nhạc YouTube (chỉ lấy Audio -m)
xfce4-terminal \
  --title="DesktopYTMusic" \
  --geometry=52x14+35+45 \
  --hide-menubar \
  --hide-borders \
  --hide-toolbar \
  --hide-scrollbar \
  -e "ytfzf -m" &

# Đợi 1s rồi ghim cửa sổ xuống lớp hình nền (Below)
sleep 1
wmctrl -r "DesktopYTMusic" -b add,below,sticky
