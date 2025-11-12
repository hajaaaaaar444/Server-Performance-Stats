#!/bin/bash
echo "Server Performance Stats"
echo ""

echo "=== CPU USAGE ==="
cpu_usage=$(top -bn1 | grep "Cpu" | awk '{print 100 - $8}')
echo "CPU usage: ${cpu_usage}%"
echo ""

echo "=== MEMORY USAGE ==="
mem_total=$(free | grep "Mem" | awk '{print $2}')
mem_used=$(free | grep "Mem" | awk '{print $3}')
mem_free=$(free | grep "Mem" | awk '{print $4}')
mem_used_percent=$(awk "BEGIN {printf \"%.2f\", ($mem_used/$mem_total)*100}")
mem_free_percent=$(awk "BEGIN {printf \"%.2f\", ($mem_free/$mem_total)*100}")

echo "Total: $(free -h | grep "Mem" | awk '{print $2}')"
echo "Used: $(free -h | grep "Mem" | awk '{print $3}') (${mem_used_percent}%)"
echo "Free: $(free -h | grep "Mem" | awk '{print $4}') (${mem_free_percent}%)"
echo ""

echo "=== DISK USAGE ==="
df -h --exclude-type=tmpfs --exclude-type=devtmpfs | head -1
df -h --exclude-type=tmpfs --exclude-type=devtmpfs | grep -v "Filesystem"
echo ""

echo "=== TOP 5 PROCESSES BY CPU ==="
ps aux --sort=-pcpu | head -6
echo ""

echo "=== TOP 5 PROCESSES BY MEMORY ==="
ps aux --sort=-pmem | head -6
echo ""
