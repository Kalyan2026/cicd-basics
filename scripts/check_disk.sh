#!/bin/bash

THRESHOLD=80
alert=0

while read -r fs size used avail use mount; do
    usage=${use%\%}

    if [[ "$usage" =~ ^[0-9]+$ ]] && [ "$usage" -ge "$THRESHOLD" ]; then
        echo "WARNING: Disk usage high with $usage% in $fs mounted on $mount"
        alert=1
    fi

done < <(df -h | tail -n +2)

if [ "$alert" -eq 1 ]; then
    echo "Disks having issues"
    exit 1
else
    echo "All disks are normal"
    exit 0
fi