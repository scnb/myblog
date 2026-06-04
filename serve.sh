#!/bin/bash
# 启动 Hugo 开发服务器，局域网内其他设备可访问
IP=$(ip addr show | grep -oP 'inet \K[\d.]+' | grep -v '127.0.0.1' | head -1)
echo "Starting Hugo server at http://${IP}:1313"
hugo server --bind 0.0.0.0 --port 1313 --baseURL "http://${IP}:1313"
