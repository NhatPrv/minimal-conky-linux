#!/bin/bash

# Chạy xfce4-terminal dạng nhúng Desktop
xfce4-terminal \
  --title="DesktopMusicPlayer" \
  --geometry=52x14+35+45 \
  --hide-menubar \
  --hide-borders \
  --hide-toolbar \
  --hide-scrollbar \
  -e cmus &

# Đợi 1s để cửa sổ mở rồi ghim xuống lớp Desktop (Below)
sleep 1
wmctrl -r "DesktopMusicPlayer" -b add,below,sticky
