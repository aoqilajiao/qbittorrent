#!/bin/bash

# 服务名
SERVICE="qbittorrent-nox@admin"

# GitHub 下载 URL
URL="https://github.com/aoqilajiao/qbittorrent/raw/main/qbittorrent-nox.7z"

# 本地临时路径
TMP_DIR="/tmp/qbittorrent_upgrade"
TMP_FILE="$TMP_DIR/qbittorrent-nox.7z"

# 创建临时目录
mkdir -p "$TMP_DIR"

echo "停止服务 $SERVICE ..."
systemctl stop "$SERVICE"

echo "下载最新版本..."
wget -O "$TMP_FILE" "$URL"

echo "解压覆盖..."
7z x "$TMP_FILE" -o"$TMP_DIR" -y

# 假设解压后有 qbittorrent-nox 可执行文件
cp -f "$TMP_DIR/qbittorrent-nox" /usr/bin/qbittorrent-nox

echo "修改权限..."
chmod 755 /usr/bin/qbittorrent-nox

echo "启动服务 $SERVICE ..."
systemctl start "$SERVICE"

echo "升级完成 ✅"
