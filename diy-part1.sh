#!/bin/bash
# diy-part1.sh - 编译前的定制脚本（精简版）

echo "=========================================="
echo "Starting diy-part1.sh (Pre-compile)"
echo "=========================================="

# 1. 添加 SSR Plus 源
echo "Adding SSR Plus feed..."
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> feeds.conf.default

# 2. 更新所有 feeds
echo "Updating feeds..."
./scripts/feeds update -a
./scripts/feeds install -a

# 3. 修改默认 IP 地址
echo "Changing default IP to 192.168.2.2..."
sed -i 's/192.168.1.1/192.168.2.2/g' package/base-files/files/bin/config_generate

# 4. 安装 SSR Plus
echo "Installing SSR Plus..."
./scripts/feeds install luci-app-ssr-plus

echo "=========================================="
echo "diy-part1.sh completed successfully"
echo "=========================================="
