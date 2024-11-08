#!/bin/bash

echo "Server Performance Stats"
echo "------------------------"
echo "Total CPU Usage:"
mpstat | grep -A 5 "%idle" | tail -n 1 | awk '{print 100 - $ 12"%"}'

echo "Total Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB (%.2f%%)\n", $3, $3*100/$2, $4, $4*100/$2}'

echo "Total Disk Usage:"
df -h --total | grep 'total' | awk '{printf "Used: %s (%s), Free: %s\n", $3, $5, $4}'

echo "Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

echo "Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

echo "------------------------"