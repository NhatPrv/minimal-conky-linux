#!/bin/bash
killall conky
sleep 2

conky -c ~/.config/conky/widgets/clock.conf &
conky -c ~/.config/conky/widgets/cpu_ram.conf &
conky -c ~/.config/conky/widgets/graphics_disk.conf &
